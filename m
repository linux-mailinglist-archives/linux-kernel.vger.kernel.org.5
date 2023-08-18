Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2F7803A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357182AbjHRCJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357177AbjHRCJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:09:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E86B30F7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:09:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf092a16c9so3857225ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692324539; x=1692929339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQO+tddRAnvm1Y0O/G7nm0nkNpa8hL+SzVrIhoe3Bps=;
        b=IoVLuigVtPp8DOJ8n1RJ6HzHQ/Ok9+SLuDZrW9U1AVkclsgcwXWTusdeHcF6vLF/PX
         aqwsIYUDtZeo8mHWtTovXbGbTYd+9a3NtYdz69CAVWKyYPP8pteI4yfC+rFnW9rGKa/Q
         7fMquqegQ1TAexaH85CDULvGDEqiMkzvhvWi7dy+gXggXiLeXMVWyZCZ8ON7lpK1xRxh
         9Z2pGKfzWG4QPVA13znLsmRV15lVVhGawimerL7jNBIrFk8qNuC+dFrlwoy8t1563bJH
         EXB7kO466AO8ceLM6vYAlarSJT4oVel1cE89rnkRu5QK42qLXqlHgAC8LWpOQSEK1/SE
         Os/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692324539; x=1692929339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQO+tddRAnvm1Y0O/G7nm0nkNpa8hL+SzVrIhoe3Bps=;
        b=NUDvn15V04BZBoyElp8vxqUBhHJk2xoJtHjuYp431OSu9IeDYuNZsbIy5WrkFTZ0vq
         O8tWZZnYh6OGd2hf5COoNAdDRN2x29l7b8vzoriJsHML843oDvPNvb7xb8TgbCirybYf
         uigFCvm0ciSbxHrAinNzlUSBRAbOY64WQFDj7vPS4d85TaCLdNJwlk8TgkGOIjfBcIwp
         aZaC2vxn+9KUeQ3n3JRF01eBKXLkMsLRjhXsZqJxQPUR1yDe3bKX0TKttNO23e/Cit5w
         KgJwZRmuVfctTfMymw3fyFPQGmiNkE/aYvZ6L/oBsvIPmSiNqZOff3L4CiY353UG/veZ
         fafw==
X-Gm-Message-State: AOJu0YzjsdBPilhqm4Wq3xDGKUF7jZceyiFT9Ogj8aCz27IQf55nQQVZ
        FJ7Y1/TE/cTarfOOZyKArWokoWuqGAI=
X-Google-Smtp-Source: AGHT+IHnhLsteg+3d6QlKPIEsZ/4KsoKmpy4Nyss/dR1dGJ1hDQYRCwUOrhIBtysdviJXwgIyBK/0g==
X-Received: by 2002:a17:902:e811:b0:1b8:8af0:416f with SMTP id u17-20020a170902e81100b001b88af0416fmr1489153plg.1.1692324539441;
        Thu, 17 Aug 2023 19:08:59 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id bg5-20020a1709028e8500b001b8baa83639sm435806plb.200.2023.08.17.19.08.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 19:08:59 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:18:40 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH 1/8] erofs: simplify z_erofs_read_fragment()
Message-ID: <20230818101840.0000524c.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 16:28:06 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> A trivial cleanup to make the fragment handling logic more clear.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
