Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3B80502A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbjLEKZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344936AbjLEKZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:25:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2079A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:25:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1cee2c1620so8001466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1701771911; x=1702376711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuMrtCTxc/rwSxWM6RfiW8lxd73OwGkuulv/1+2LtXE=;
        b=U7UKC4gC3LFPYpgi+TRHDThxSNQCt8ijcm9C7Sn7SngLpfC/yFXtQTu9Nlu7Qw6dSu
         9JQdLVD030FAIjA5/3pDYRIe9t7PZuOCEDtyWE34s9X3x6yRQAVLooM2ly84VXlGJClN
         bZw5n8ZcOlUR3jR1oOLxsvqFKFTjSVgl/wziKaMh9FhduS7/JHjeacGdzR1g7mFLVqu6
         b57DlePp5bjyL0UC07qIhnHyL7sGgenOVQnMVHzN+/0lOu0l6GdnhcuDxDQbWiMf1Q1C
         2t2yOey9zva2OgozfH/yOcgyUK2gObdeHxRQVMAWtdLNStTfeGHk8PKxJZVm9FxHUhXV
         vyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701771911; x=1702376711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuMrtCTxc/rwSxWM6RfiW8lxd73OwGkuulv/1+2LtXE=;
        b=LWp5nMxsQSy7S9na6L3ZaMIY3k9f0UvfSci1dbzHRUre9YGb6zv4lr7hdXLhRNL2Lz
         jg3rLr9s+Cb7snucJohIUrSyMxiAw1v2aMoswcpDeP+6h85t38604ePhR9xN1S/9mCWr
         h07BB8vhBdVDXgQYbdZ91U/OesMUVgPIO3ireiKaBjRBYnjrAwsg1IxHGqHtGgIs67S0
         ydInqJOw5c9iNTOccE+b3ey/tYqbL53fA1qsni7nnNhC1CA73Aq9CPpo2DkLP3PA8qB+
         RpbgzYAaIy86fSatPMxjQahIVfTJaZn4rNgzfl+hHAJqBrSDWd8M7pXzx4bixvtNJvjz
         AGwQ==
X-Gm-Message-State: AOJu0Yx24EPBIpcPnNX1hKu2TNZKPu4AmrrtNLBKYLWWxJXrQHcmxpQW
        Kj2uN62L5Zgn1NbnLkgBkFwV5Q==
X-Google-Smtp-Source: AGHT+IFpqjSA6fEH7od+GFIjOUzVVjISROfioII5ogZUOmrH7WdAoPftJWF2x3t5erkpxqO7eOldVA==
X-Received: by 2002:a17:906:15c:b0:a19:d40a:d20b with SMTP id 28-20020a170906015c00b00a19d40ad20bmr1974841ejh.215.1701771910944;
        Tue, 05 Dec 2023 02:25:10 -0800 (PST)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.gmail.com with ESMTPSA id ay19-20020a170906d29300b00a0c3b122a1esm6467111ejb.63.2023.12.05.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:25:10 -0800 (PST)
Date:   Tue, 5 Dec 2023 11:25:03 +0100
From:   Petr Malat <oss@malat.biz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded config
Message-ID: <ZW76f0Rt8TM0h56I@ntb.petris.klfree.czf>
References: <20231121231342.193646-1-oss@malat.biz>
 <20231121231342.193646-3-oss@malat.biz>
 <20231123194106.08f5832f558fe806b1fd8098@kernel.org>
 <ZWADKWURCDZXyJTQ@ntb.petris.klfree.czf>
 <20231127074630.993db80be06f03067d8a1aef@kernel.org>
 <ZWSvfgFFu+ILKN4H@ntb.petris.klfree.czf>
 <20231128071355.1fd8b2857f4622bd111d8647@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128071355.1fd8b2857f4622bd111d8647@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Sorry for late reply, I didn't have much time to work on this the last week.

On Tue, Nov 28, 2023 at 07:13:55AM +0900, Masami Hiramatsu wrote:
> On Mon, 27 Nov 2023 16:02:22 +0100
> Petr Malat <oss@malat.biz> wrote:
> 
> > Hi Masami,
> > On Mon, Nov 27, 2023 at 07:46:30AM +0900, Masami Hiramatsu wrote:
> > 
> > Shortened the mail as this seems to be the last open point
> > 
> > > > > And as I pointed, we can remove CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD so this case
> > > > > should be removed.
> > > > 
> > > > I have added BOOT_CONFIG_EMBED_APPEND_INITRD, because it's not backward
> > > > compatible change and I didn't want to risk breaking current use cases.
> > > > My change tries to get early options working without affecting how
> > > > other options are handled, but I think appending the config is more
> > > > reasonable behavior and if you do not see it as a problem to not be
> > > > backward compatible here, I will delete the "replace" behavior.
> > > 
> > > That's a good point. OK if disabling CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD,
> > > it must skip setting early_params to avoid "hidden setting" from the
> > > embedded bootconfig.
> >  
> > That's not a good idea because then disabling BOOT_CONFIG_EMBED_APPEND_INITRD
> > would disable early options handling even if the user doesn't use initrd at
> > all, which we do not want.
> 
> Yes, so the config name and comment needs to be updated. The problematic point
> is that we can not know where there is an initrd (and bootconfig on initrd)
> until parsing/applying the early params. And we have to avoid setting "hidden"
> parameter.
> 
> > 
> > I suggest logging a KERN_NOTICE message if any early option was applied and
> > at the same time embedded bootconfig was replaced.
> 
> No, that's no good because kernel log can be cleared.
> Usually user will check /proc/cmdline to check what parameters are set, so at
> least it needs to be updated, but also, we need to keep the original cmdline
> for make sure the user can reuse it for kexec. To solve this issue without
> contradiction, we need to ask user to set BOOT_CONFIG_EMBED_APPEND_INITRD=y
> to support early params in bootconfig. (Thus it will be something like
> "BOOT_CONFIG_EMBED_EARLY_PARAM")

I made a bit of prototyping and I can add applied early options from embedded
config to /proc/cmdline even when the embedded config is replaced. I don't like
applying these options conditionally, because that leads to confusing behavior
of seeing these options in /proc/cmdline and /proc/bootconfig without actually
applying them. I find that worst than the opposite behavior as if user sets
options in the config and then sees them in both cmdline and bootconfig, he
assumes they have been applied.

We can also introduce BOOT_CONFIG_EMBED_REPLACE_INITRD for backward compatibility
and write that this option will be removed in the future. If nobody complains
for a while, we drop it. Then we are left with the appending only.
  Petr
