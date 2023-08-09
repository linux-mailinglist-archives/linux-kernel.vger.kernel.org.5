Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9948D7767BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjHIS5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjHIS5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A704FE64
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691607400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOeT56fYFXenbiTjEbqIlGNmaCm7sLXNGQKrx5ZWC5o=;
        b=Y+AkhpLHgnwnSiA6u9NOR+xPU4+QBlT7bFAqpmN0lKYUrH3H0kV/sHbZNg0YVXbFEBnUE1
        ikT8Zms6Z3pOG3u/14+O5U0JQWynNg2vC5HTMQt5KSGi8sOkJaSE2mCzuIsjt+6uvg5mES
        ar2HxWJmWVazt7f7gBFMbBV5y+qgARA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-Hpw4IH9dMLa4TOVXp5_izg-1; Wed, 09 Aug 2023 14:56:37 -0400
X-MC-Unique: Hpw4IH9dMLa4TOVXp5_izg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-57320c10635so2699547b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 11:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691607396; x=1692212196;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOeT56fYFXenbiTjEbqIlGNmaCm7sLXNGQKrx5ZWC5o=;
        b=SNARXmRuj3pC+n4mbYd04h78Bw4sb7WJbhg9pCQ5l0QWpZXsGrsUoRd9PxFmActm/9
         ynibPqVbB3nJRkjKOs75VkU4DAr77/NSJSs5nHtq5G3uSEklq0TWFd8aZCR/qd0vr8Vw
         RvV2TOUgRb9d0+Qac9NYOP3z3pQAmG905j3Pe4rYrOPiWVCV/7rm/XSRbqVkc5RJ4L7t
         Ua+ld2wxahalemkuTmYTA4ZxwAXPUEtXU5G6csM8f8sPe8BcshDX+xBmQ3bZHnIxbX1V
         FR0q4P4kVunvtN1bbfi5wkf/ig2Yinw3Vk8yD7zk88/9y7+pv+WTZVDc3y8NpJCY2vgN
         dtiw==
X-Gm-Message-State: AOJu0YyJrLYLTD5IYYpWhIYpbQpX1mauLSYBJlApI2tFOv1p9ZejG3KC
        UvabLf2FIoNeUEBAMfaEEspC7gD1/VFQXDSvEidLLht7FMpunD/ULFFnoz2kIqhpcvDTg6dnLH5
        yV27i0x67dgpRuVJvglYsrdOSOZri7Ma3
X-Received: by 2002:a81:4f91:0:b0:57a:9b2c:51f1 with SMTP id d139-20020a814f91000000b0057a9b2c51f1mr211515ywb.1.1691607396773;
        Wed, 09 Aug 2023 11:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeb8QRGb74j1vFryxurJ7SZstqb4N5IPmc6D8B1e4Q/O0UeGAeI1H9yFfnG7Vqoixf40LJ4Q==
X-Received: by 2002:a81:4f91:0:b0:57a:9b2c:51f1 with SMTP id d139-20020a814f91000000b0057a9b2c51f1mr211500ywb.1.1691607396536;
        Wed, 09 Aug 2023 11:56:36 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id e9-20020a81dd09000000b0058038e6609csm4101487ywn.74.2023.08.09.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 11:56:35 -0700 (PDT)
Date:   Wed, 9 Aug 2023 14:56:33 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: ufs: core: convert to dev_err_probe() in
 hba_init
Message-ID: <ZNPhYRslrcwAHo3Y@brian-x1>
References: <20230808142650.1713432-1-bmasney@redhat.com>
 <20230808142650.1713432-2-bmasney@redhat.com>
 <20230808162929.a1b784ad42bd346cd87747b9@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808162929.a1b784ad42bd346cd87747b9@hugovil.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 04:29:29PM -0400, Hugo Villeneuve wrote:
> On Tue,  8 Aug 2023 10:26:49 -0400
> Brian Masney <bmasney@redhat.com> wrote:
> 
> > Convert ufshcd_variant_hba_init() over to use dev_err_probe() to avoid
> > log messages like the following on bootup:
> > 
> >     ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qcom init
> >         failed err -517
> > 
> > While changes are being made here, let's go ahead and clean up the rest
> > of that function.
> 
> Hi,
> you should not combine code cleanup and fixes/improvements in the same
> patch, split them.

This is a pretty simple patch as is, and split up the code clean up is
not very useful on its own. I'll just skip doing the code cleanup and
only post the dev_err_probe() change in v2.

Brian

