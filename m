Return-Path: <linux-kernel+bounces-22901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BD82A524
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F7528592B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144CB15ACD;
	Thu, 11 Jan 2024 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vc28TvXz"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8815AC6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4ca2fd2fbso25324395ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704931410; x=1705536210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba4Wlhw2vCHiq+Wpp/loRi1cOOmQkbqPw4UUSpZg/xo=;
        b=Vc28TvXz7MCg/0+a6kZy8X0I1doO37oxUP/5KPlYRlwt3Nk0WV3489ekJzhy0SkUTH
         2Y5SZEnnrOKtFtxPeUpuXh5fkShioRbViQidC39wzsT5FIZ0Zs2gVNAos7Xzy6RB1yu0
         YPiLi1mUjq8g9X1c1HvDy8OFb2KxuS2WxhJw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704931410; x=1705536210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba4Wlhw2vCHiq+Wpp/loRi1cOOmQkbqPw4UUSpZg/xo=;
        b=t+48LSF95x5LdkTbo2t7b7DWuP03Ymui+fIdDBxVFyC/ImovQS7tSlyV7ENimNknHq
         pysaKrH1O2XlCrPYsnr5iidJJexoYWnUuiqJV8Vc7JSd0Oyia7vdQiw6UC15dBdyHUIb
         dg/q6SJyRumntmZfDadMpKabdoudOaPZGifyadZvH09uTayKsxvy9+PSiywkMRY5VODY
         +Qo6t7RyQn1WMxr0GAMA+pQOvUrylsP7LCiW1mmljLb5ri7JfbqzgeLpnZQtrHcEi9Ny
         9fnYV8OI62LEqiCLnBhkgYydnoE/Ee5TGJWHcvMusDL9xnNJj38RZWiViaPXy17fjK6t
         I57Q==
X-Gm-Message-State: AOJu0YwMN8Pfi7k3HlODag79wSzq2WzbIxhw7BTeGMiMsnB7kICn+NfV
	XXdTzGP65Ryom9yG0TpGd9LcTgWzPGj9
X-Google-Smtp-Source: AGHT+IH/q5mx8pcXScPlJfZ0Wh44Wk98MeulCYW2AroSeNwaysjkH6eufQcIXWUMDkxuUXHl3w9CbQ==
X-Received: by 2002:a17:902:e843:b0:1d4:be2a:ae2c with SMTP id t3-20020a170902e84300b001d4be2aae2cmr301395plg.77.1704931409677;
        Wed, 10 Jan 2024 16:03:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902d4c700b001d362b6b0eesm4246119plg.168.2024.01.10.16.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 16:03:28 -0800 (PST)
Date: Wed, 10 Jan 2024 16:03:28 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-hardening@vger.kernel.org, error27@gmail.com,
	gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Message-ID: <202401101601.30ED61A1A3@keescook>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
 <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>

On Mon, Jan 08, 2024 at 08:05:38PM -0600, Gustavo A. R. Silva wrote:
> On 1/8/24 16:37, Kees Cook wrote:
> > On Fri, Jan 05, 2024 at 08:40:00AM -0800, Harshit Mogalapalli wrote:
> > > Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
> > > 
> > > memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
> > > at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
> > > 
> > > WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
> > > dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
> > > 
> > > Some code commentry, based on my understanding:
> > > 
> > > 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
> > > /// This is 24 + payload_size
> > > 
> > > memcpy(&dg_info->msg, dg, dg_size);
> > > 	Destination = dg_info->msg ---> this is a 24 byte
> > > 					structure(struct vmci_datagram)
> > > 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
> > > 	Size = dg_size = 24 + payload_size
> > > 
> > > {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
> > > 
> > >   35 struct delayed_datagram_info {
> > >   36         struct datagram_entry *entry;
> > >   37         struct work_struct work;
> > >   38         bool in_dg_host_queue;
> > >   39         /* msg and msg_payload must be together. */
> > >   40         struct vmci_datagram msg;
> > >   41         u8 msg_payload[];
> > >   42 };
> > > 
> > > So those extra bytes of payload are copied into msg_payload[], a run time
> > > warning is seen while fuzzing with Syzkaller.
> > > 
> > > One possible way to fix the warning is to split the memcpy() into
> > > two parts -- one -- direct assignment of msg and second taking care of payload.
> > > 
> > > Gustavo quoted:
> > > "Under FORTIFY_SOURCE we should not copy data across multiple members
> > > in a structure."
> > > 
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
> > > Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > 
> > Thanks for getting this fixed!
> > 
> > Yeah, it's a "false positive" in the sense that the code was expecting
> 
> It's a false positive _bug_, and a legitimate _warning_ coming from fortified
> memcpy().
> 
> > to write into msg_payload. The warning is triggered because of the write
> > across the flex array boundary, which trips a bug in GCC and Clang,
> > which we're forced to work around.
> 
> The warning is triggered because of a write beyond the boundaries of
> `dg_info->msg`. It's not directly related to the fact that there is a
> flexible-array member following `dg_info->msg`.
> 
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832 (fixed in GCC 14+)
> > 	 (not yet fixed in Clang)
> 
> This issue is not related to the compiler bugs mentioned above.

Oops, yes, thanks for fixing my confusion. Right, this is a direct write
across members into the flex array, not a composite destination. Yay
all the corner cases. :P

-- 
Kees Cook

