Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F863764569
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjG0FWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG0FWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:22:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2424826A1;
        Wed, 26 Jul 2023 22:22:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-317716a4622so554215f8f.1;
        Wed, 26 Jul 2023 22:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690435328; x=1691040128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zu+TPu8vc5z407cLLTcD0tM3SAh82DPnoPRhY7CjDH8=;
        b=BTJaFlWMXhbYZaQanG+xg4emhc+hhhvUk47ZrMZ0EiTYhk9s7YgWF3qPS07zTSRkne
         wI54D260XhItT6aZ+NgVdCFLFrj/v4mZwR237D27dclMwsLp/mRBsKsHVtHHMq6QWNHo
         xvJiMlY2tfsmswEeyr8Xm78xl5Ti5xcRpPV3YYf8pCYvs0gb0cdp20btX2xU+ZiY5aAn
         Gbk+gryvRkILcxZPiZxVXvuxUoV03e0caxrTw1jgrTYAI6HCjPOfW0X+SFE/gf3USUAZ
         5oExijmaJEIcrhcgl3PUATRtathZGlZMayplGCslIHRHEioTMID1bsxe6/8izyNIIz91
         5Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690435328; x=1691040128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu+TPu8vc5z407cLLTcD0tM3SAh82DPnoPRhY7CjDH8=;
        b=HlThIu/hyyug3GQxlWYFdAsodF89z8X6F5UXdOJ7WCovol+l4Wvnk5dB4MWWoity/X
         A7kGeEhSzgk0USiSFFL3InxQsrYDr8y906lieI1CuPThN7DGt8Becv7V2BRBEHRGCWF8
         h/r9eNPm5/1jCx1DSs2sj24RdMrLmItfjg+Cu7mKzh/OHJiniPLEbypPJiOYk8P9/XZh
         2N50tvFU4KOnLr2I+64PHzVTgR0p6X/0TauXajAa1vYTboxEi5fiSteRruiYo0ctfl7s
         RqAaaEjn5KncUrhRQyDDH6h6mBobzYu4TGd1VRdi9LJdU/J634bA4UkxpN7v9qb4QB/L
         dISA==
X-Gm-Message-State: ABy/qLbv2zT5t/wwG/3KSqwokrSIdlC/s2slTmAhwYGELnRTWkgCp15x
        CkPkp8LDmOstudTrNQSqOmEbD0BpGERTEbCD1cc=
X-Google-Smtp-Source: APBJJlHKb/e5eTfcqSQ09CINh7JgQDQGk6myc+uS3OwL7JKK7UjH9Y66gbVO3meh6qK4rCcDgrU39buz7Ga9b73gWWE=
X-Received: by 2002:a5d:6e42:0:b0:314:21b:1ea2 with SMTP id
 j2-20020a5d6e42000000b00314021b1ea2mr819278wrz.39.1690435328409; Wed, 26 Jul
 2023 22:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230726181322.26754-1-dg573847474@gmail.com>
In-Reply-To: <20230726181322.26754-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 27 Jul 2023 13:21:57 +0800
Message-ID: <CAAo+4rV1GKrzo77Sum89n6ysDyhVhzrM2OX-ADk9AOrFkZfQow@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: lpfc: Fix potential deadlock on &ndlp->lock
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        justin.tee@broadcom.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the interruption, I just notice that the ndlp node
inside timer does not share with that of lpfc_cleanup_pending_mbox().

This is a false alarm and sorry again for this.

Best regards,
Chengfeng
