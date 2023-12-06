Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E78807C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379630AbjLFXFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379634AbjLFXFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:05:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81974199F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:04:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-286e57fde73so324302a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 15:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701903899; x=1702508699; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HI6nSYbxQkTs8xlGNUbdTpMvMqVQhr8L/otXNNzVlQ4=;
        b=X/AC4GTbE3uhVxgQIQxC1dZXACc/OGrorhCehU5kixCH34it2DuWkcVgoDdknM25Z+
         VsE4BQEyDiPND6y6ZDxxTvlG4uwvnY20AkE7yvfyRejcIyhmcH64gllXifMdAhxSBckC
         bqA+sDP0qzq2wBC+ucwwcQj6DrNfjzGLRJQAZfu5fEfgiaL3xieEul6oAmsg4c0WHF+W
         FsxKhxYWtpfdT0v+jEcYmVjggvHHl08G0YD8h60idaFELR7qG4yDNBCMh4Sztf2COXrZ
         4TFFn9dDy+4/ypxzScwYlG1sg08pCgaQAZhZ7n+BuljuE0ZR/INQMs2guKUic0A2prDz
         A3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701903899; x=1702508699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI6nSYbxQkTs8xlGNUbdTpMvMqVQhr8L/otXNNzVlQ4=;
        b=UfMOJBGPOgG96GsjJ5blpVo1s+btinjKSrSUZsT1nly3k01+v5cSEpR6zftoUO7dqd
         lnd7SfVYY+auvF3N4Si4r/+mR/kifKq0CX1NRMWZ1gCOsOawW9dGKKvDSgmIGXHnMYTS
         vhGEAEuG6VNDPuND8gOEDQkbOoZV56ogIMXLwfnKwZ2+HVp1uJKQJ/n5FAPjePMAmlB0
         ZV8u/ANC7NMs3H0OHtiLqILiwaCQhm5cmKe57SYsrrjw8CS9YmpXze3qE0FL0CuzNder
         v6Aj3XcjmIE9s8s/LfBM+xndpQYNUXNebJnf+Ik0lDPO7W3+HTNgvaLeuCKIDfXpg4V8
         yR2g==
X-Gm-Message-State: AOJu0YwqwJPGnqDzTIVvz1Hhe7JIIJ77rGCBhQbGLUE41V9boCmiMYqY
        KBDrRA1/RvE4a1ekhnAbtHd2+A==
X-Google-Smtp-Source: AGHT+IGtV8O0jKV+PArM/vMQoTwS1VwmuVzmwzYgDqA70uTeS8V1FVVZ04FDi0IUF605HhQUM9Ny9w==
X-Received: by 2002:a17:90a:dc13:b0:286:6cc0:b910 with SMTP id i19-20020a17090adc1300b002866cc0b910mr1289456pjv.71.1701903898922;
        Wed, 06 Dec 2023 15:04:58 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001d0ca40157bsm326478plb.260.2023.12.06.15.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:04:58 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1rB0wp-004p7R-2v;
        Thu, 07 Dec 2023 10:04:55 +1100
Date:   Thu, 7 Dec 2023 10:04:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        gfs2@lists.linux.dev, dm-devel@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] selinux: use dlist for isec inode list
Message-ID: <ZXD+F5N/3PPSGTya@dread.disaster.area>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-6-david@fromorbit.com>
 <CAHC9VhTP3hRAkmp7wOKGrEzY5OXXJpnuofTG_+KdXDku18vkeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTP3hRAkmp7wOKGrEzY5OXXJpnuofTG_+KdXDku18vkeA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 04:52:42PM -0500, Paul Moore wrote:
> On Wed, Dec 6, 2023 at 1:07 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Because it's a horrible point of lock contention under heavily
> > concurrent directory traversals...
> >
> >   - 12.14% d_instantiate
> >      - 12.06% security_d_instantiate
> >         - 12.13% selinux_d_instantiate
> >            - 12.16% inode_doinit_with_dentry
> >               - 15.45% _raw_spin_lock
> >                  - do_raw_spin_lock
> >                       14.68% __pv_queued_spin_lock_slowpath
> >
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  include/linux/dlock-list.h        |  9 ++++
> >  security/selinux/hooks.c          | 72 +++++++++++++++----------------
> >  security/selinux/include/objsec.h |  6 +--
> >  3 files changed, 47 insertions(+), 40 deletions(-)
> 
> In the cover letter you talk about testing, but I didn't see any
> mention of testing with SELinux enabled.  Given the lock contention
> stats in the description above I'm going to assume you did test this
> and pass along my ACK, but if you haven't tested the changes below
> please do before sending this anywhere important.

AFAIA, I've been testing with selinux enabled - I'm trying to run
these tests in an environment as close to typical production systems
as possible and that means selinux needs to be enabled.

As such, all the fstests and perf testing has been done with selinux
in permissive mode using "-o context=system_u:object_r:root_t:s0" as
the default context for the mount.

I see this sort of thing in the profiles:

- 87.13% path_lookupat
   - 86.46% walk_component
      - 84.20% lookup_slow
	 - 84.05% __lookup_slow
	    - 80.81% xfs_vn_lookup
	       - 77.84% xfs_lookup
....
	       - 2.91% d_splice_alias
		  - 1.52% security_d_instantiate
		     - 1.50% selinux_d_instantiate
			- 1.47% inode_doinit_with_dentry
			   - 0.83% inode_doinit_use_xattr
				0.52% __vfs_getxattr

Which tells me that selinux is definitely doing -something- on every
inode being instantiated, so I'm pretty sure the security and
selinux paths are getting exercised...

> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
