Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF441764678
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjG0GKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjG0GJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260621710
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690438151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YYQikt/RSGLbWmkNXwyvyF8FZ4OuKgmHNL/qSc2r2Mw=;
        b=ShI5wa14RjpfXIZXrq4bWPoOfPfCotiqo0KRNFHsGfKf0Q0A9RGbIHF9EJl2dM3AbiYMTV
        0VeHwg0+lVc4JcZom3NlPwnfHtt7sFPix9jUp1KUgsWZdm1GPD0Jf9UOtSTQ3UtdLjYtqq
        F+4idMHKKxXBxsgy2ObomRvVwtD7EBE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-S5m9whOvPceMymPTWikesg-1; Thu, 27 Jul 2023 02:09:09 -0400
X-MC-Unique: S5m9whOvPceMymPTWikesg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fd2e898badso2126605e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690438148; x=1691042948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYQikt/RSGLbWmkNXwyvyF8FZ4OuKgmHNL/qSc2r2Mw=;
        b=Q9c3yRYHg1WyqTWBk/rjyVx9OWMkmtxkm1L5A/SCOHN6e2z5kDGnhZ02w2N3pvDX0g
         nNXnDoQnAnZagqwnut2nM9pOYPu1m1o4ruNpYSUvxRukyKI0pToKGUhF0qVBk9QjylGx
         1x2vUF9CHWYtfHJ0nQCKozGBY90S4Ri8+pD/81lexVtwIfkxAQS34wEme1u3PgMJJG3q
         aDD4jv1itTH2v4olZkkrnBs0VeGNmcODOjgxpTV6KB58s5syNNQIMLNizmz6ZZNDNF64
         yNpb62OQLDA2YCmLB2OFGnj8WBCunfx5I71sq3GzvwYZey7sYJ0nyz8Odw8QRq0VkzH4
         dPvA==
X-Gm-Message-State: ABy/qLYM3Gr/ZajsFxmeL1Vy1B88f2v8+CNqVk9GR/B1x1ACR5m6napK
        9gYNEcKHhD7qUMhmhOIlpQoYrTc5nVeU6r5M9leO2A6v64JTO0uKjJt2nDJt81WvC91VDJ8drCu
        g8Gvc/7x1qmXHgkLcwgqKOs40
X-Received: by 2002:a05:600c:21d8:b0:3fd:dd53:d9a3 with SMTP id x24-20020a05600c21d800b003fddd53d9a3mr774467wmj.17.1690438148433;
        Wed, 26 Jul 2023 23:09:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFEJZQhApZRMbtLl2Ru/qutbhOPA4DROP8Vhc2vZ299DZKe6FqdK5pidW3CwisM1rCOLNo8mQ==
X-Received: by 2002:a05:600c:21d8:b0:3fd:dd53:d9a3 with SMTP id x24-20020a05600c21d800b003fddd53d9a3mr774455wmj.17.1690438148167;
        Wed, 26 Jul 2023 23:09:08 -0700 (PDT)
Received: from redhat.com ([31.187.78.131])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c1d0500b003fbb1ce274fsm15354729wms.0.2023.07.26.23.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 23:09:07 -0700 (PDT)
Date:   Thu, 27 Jul 2023 02:09:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Woody Suwalski <terraluna977@gmail.com>, imammedo@redhat.com,
        bhelgaas@google.com, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Subject: Re: Kernel 6.5-rc2: system crash on suspend bisected
Message-ID: <20230727020621-mutt-send-email-mst@kernel.org>
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
 <20230720202110.GA544761@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720202110.GA544761@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 03:21:10PM -0500, Bjorn Helgaas wrote:
> [+cc regressions list]
> 
> On Wed, Jul 19, 2023 at 11:36:51PM -0400, Woody Suwalski wrote:
> > Laptop shows a kernel crash trace after a first suspend to ram, on a second
> > attempt to suspend it becomes frozen solid. This is 100% repeatable with a
> > 6.5-rc2 kernel, not happening with a 6.4 kernel - see the attached dmesg
> > output.
> > 
> > I have bisected the kernel uilds and it points to :
> > [40613da52b13fb21c5566f10b287e0ca8c12c4e9] PCI: acpiphp: Reassign resources
> > on bridge if necessary
> > 
> > Reversing this patch seems to fix the kernel crash problem on my laptop.
> 
> Thank you very much for all your work debugging, bisecting, and
> reporting this!  This is incredibly helpful.
> 
> Original report, including complete dmesg logs for both v6.4 and
> v6.5-rc2:
> https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
> 
> I queued up a revert of 40613da52b13 ("PCI: acpiphp: Reassign
> resources on bridge if necessary") (on my for-linus branch for v6.5).
> 
> It looks like a NULL pointer dereference; hopefully the fix is obvious
> and I can drop the revert and replace it with the fix.
> 
> Bjorn

Patch on list now:
https://lore.kernel.org/all/20230726123518.2361181-1-imammedo%40redhat.com

-- 
MST

