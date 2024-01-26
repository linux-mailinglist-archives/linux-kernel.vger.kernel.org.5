Return-Path: <linux-kernel+bounces-39446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91683D144
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A4A1F23EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0D68C01;
	Fri, 26 Jan 2024 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hzSBIy+T"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B52567D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227447; cv=none; b=LxBw0+zy27hg1hU6y5kS29IfwZe/8+L4Na6hOaCPzMKp22ZpyDLU4saimsnFySv1GqE9yQEhF5O1RXfrtDvoE1we8qyOW/3yA+EMB+GoSoIjKcZ8XwD70wWqMNBTIXYTEi0zeHcGTZCb3Mp8x95aVbXfwt/nPCIO+xuWLjCptik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227447; c=relaxed/simple;
	bh=7zbZOXeSYfrXL3UfSHshupsYWCGYDeTqXmv5Fpw29Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coq7j2TcOFCuNn0NhDrR0g1lNlV5nkv5nWctA+/rYQNTQcKcWr4LlbB6k98lNh6FNLYj2skDZ2Rki4ebVz5j0IcCTSBUGHCsjSaCibcq8ZavBZV2GAfgxOFOaPcz4iTNdr9FZ4vtECV5iqT36mCUaX2onUiXnazbRYxR+8v2yJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hzSBIy+T; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29036dc3a63so3412022a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706227446; x=1706832246; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt+zkT8dWPbaYHm7q/7qevYBv8gGAY6mW3zJ10wq1SE=;
        b=hzSBIy+TjaTBgKhxctcHd2aCx2964mTXstQY0xCxO9GCw4t6HYehBs2z3M10ZNSPiO
         JTS5VUBNp7WHh2g+faO7IIqTjUsQkO8ZYXL8T2CbCHbaA7ZtuXAXSJW1GUAOTV2y/S/1
         FZoM9jnyAg3XbLgP4eI6waClnJ6djymJiehBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706227446; x=1706832246;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nt+zkT8dWPbaYHm7q/7qevYBv8gGAY6mW3zJ10wq1SE=;
        b=Yc77rim6R6xN381RRj5u8K5InUnS5hTsI1UARFIkP5U3/aiky+QrX//2xext4TzfnM
         3blP8O1BLz2auljtmgG7Hzv9w2n1J9v31/jdcWLa7wXgeUOakAYNlJjWT1b1CHfifKWl
         xTOp9Av0sPHkEyVQ0tOLpW7p9XCj8KreN2cPDTzYIdjJ2raDVcaKDnNn02aN5S52dN2z
         IypwlMkn5EEG3i4p4sx8ceCe0G0+PkWPAr9leqtirBBgqgl/WEqIHPlIHcYVL3JN+13y
         +KCU7MQSobvlr9kdksgdvh4YeO4FR2p2At+jmzbVLnQKlqkXwA9pR8PIYaRi6T74sc3j
         CnmA==
X-Gm-Message-State: AOJu0Ywv6czClpEWnfRj9fWqZU7AJsvYBdcS9hrJbL2VQNGMyYm23O76
	R1w2o1/Sc+cJ+rLZXmt5gsgjaAwA0Ap+bctoyi7MfSzFLe29+aRWMngrmBdVeKA=
X-Google-Smtp-Source: AGHT+IH3PGEaEJ5fzY45STg6LjF8IDS5JBxY9N4KvoaAPzzvAAbyyjdFOLiivTEHCXcPoP38TqXmVg==
X-Received: by 2002:a17:90b:d0b:b0:290:5ae2:f2a8 with SMTP id n11-20020a17090b0d0b00b002905ae2f2a8mr532493pjz.33.1706227445731;
        Thu, 25 Jan 2024 16:04:05 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id sw12-20020a17090b2c8c00b0029105d49b2dsm96322pjb.20.2024.01.25.16.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 16:04:05 -0800 (PST)
Date: Thu, 25 Jan 2024 16:04:01 -0800
From: Joe Damato <jdamato@fastly.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240126000400.GA1987@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
 <2024012559-appraiser-coerce-b32f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012559-appraiser-coerce-b32f@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Thu, Jan 25, 2024 at 03:20:37PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -6,6 +6,8 @@
> >   *  Davide Libenzi <davidel@xmailserver.org>
> >   */
> >  
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> 
> Why this addition?  You do not add any pr_*() calls in this patch at all
> that I can see.

Thanks, I've removed this for the next version. It was a remnant from a
previous version.

