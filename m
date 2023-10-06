Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6EE7BBA52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjJFOeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJFOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:34:15 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4C968F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:34:10 -0700 (PDT)
Received: from [192.168.1.3] (gsystem.sk [85.248.217.30])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id AEDAA7A025C;
        Fri,  6 Oct 2023 16:34:09 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] video: fbdev: arkfb: fix possible object reference leak
Date:   Fri, 6 Oct 2023 16:34:01 +0200
User-Agent: KMail/1.9.10
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>, tzimmermann@suse.de,
        jiapeng.chong@linux.alibaba.com, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <tencent_55C1A344A101B55762ECA6A6366D0B0F8C05@qq.com> <b9e51034-bc6c-81d8-39ef-9fc74fa09c62@gmx.de>
In-Reply-To: <b9e51034-bc6c-81d8-39ef-9fc74fa09c62@gmx.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202310061634.02110.linux@zary.sk>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2023, Helge Deller wrote:
> On 10/5/23 09:01, Zhang Shurong wrote:
> > Add missing pci_disable_device() in error path in ark_pci_probe().
> 
> Do you have this hardware and tested your patch?
> I'm sure there is a reason, why "pci_disable_device()" was commented
> out in the original submission in commit 681e14730c73c...

pci_disable_device() call is disabled in many fbdev drivers because calling it might prevent display from working.

> 
> Additionally I'm wondering why your patch doesn't show up in
> the fbdev patchwork, although you added linux-fbdev mailing list.
> Probably a vger issue.
> 
> Helge
> 
> 
> > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> > ---
> >   drivers/video/fbdev/arkfb.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
> > index 60a96fdb5dd8..6c4e5065646f 100644
> > --- a/drivers/video/fbdev/arkfb.c
> > +++ b/drivers/video/fbdev/arkfb.c
> > @@ -1064,7 +1064,7 @@ static int ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >   err_dac:
> >   	pci_release_regions(dev);
> >   err_request_regions:
> > -/*	pci_disable_device(dev); */
> > +	pci_disable_device(dev);
> >   err_enable_device:
> >   	framebuffer_release(info);
> >   	return rc;
> > @@ -1085,7 +1085,7 @@ static void ark_pci_remove(struct pci_dev *dev)
> >
> >   		pci_iounmap(dev, info->screen_base);
> >   		pci_release_regions(dev);
> > -/*		pci_disable_device(dev); */
> > +		pci_disable_device(dev);
> >
> >   		framebuffer_release(info);
> >   	}
> 
> 



-- 
Ondrej Zary
