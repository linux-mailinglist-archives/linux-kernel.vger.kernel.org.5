Return-Path: <linux-kernel+bounces-65897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E03855376
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA4B1C25E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47B13DB86;
	Wed, 14 Feb 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oni3xf62"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760413B7B1;
	Wed, 14 Feb 2024 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940122; cv=none; b=EXq1vwhzM0Q8X3N+KEYZALlv/1t1lVi1sAdtGclRFQVTdkdTyiA1dfPECXGRU0uqLtoe4HOGFj4vK23DyODsXC9B65bY9RSSq61VdWgOMZFCDFoHILENEexpMVloYg26/Tra5cOnDWi83ion4H3X+lTBqxghwAm0UppN0eDaHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940122; c=relaxed/simple;
	bh=IT+pJ7rLKY1EyWCszkD4RE84IQ1WhJVQ6bIT6dyePEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZSw6OjWlg2Ve+TnNGxtKaMo2B+5pPbYghr/BeoPWbtr9hKa3iNRwA9Eb923ZrJfauWBU7Cnh3y7sd34IkwqkCr7nDzAmZZ+vCY0EdbGOxGPrOwNnVjhjSP5sg9PD4Tw2wnQeUDGyw0LwP4dnb5acsP5csi4nlE28gaMBapHWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oni3xf62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4834C433C7;
	Wed, 14 Feb 2024 19:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707940121;
	bh=IT+pJ7rLKY1EyWCszkD4RE84IQ1WhJVQ6bIT6dyePEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oni3xf62ILDZThYP1kvQ4yAIPTeVwO45rf7gxV7gjrUiaXmBKUcHEjPY3XLcajZPd
	 Ct6/gO1sDzXCSdCAHoylQ3bOFEMoBGAhj94POsADd7U5ZfAVrgFVnGfhsHGJa7BCBB
	 YOr7iAMnWifswpRb/IYMLSG0eYiaT7KZL7IRzmO87hzOxA8dZ8SmF+tYg09jV5ZCbK
	 u4bqOx0Wq9SY4uceRR57VltRylku6P1Aw2FRu/ytddSXq099EP+RdtOz5fSOIoqJDT
	 rSlSPl2x776TR8oIX5qWKy6DhHGJDEkiEItvcLeq1zVP8h9ci/haiil5dDHr0Ji91K
	 bb+ua854y8rSg==
Date: Wed, 14 Feb 2024 12:48:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Fangrui Song <maskray@google.com>, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, ndesaulniers@google.com,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 03/11] s390: vmlinux.lds.S: Explicitly handle '.got' and
 '.plt' sections
Message-ID: <20240214194839.GA1179178@dev-arch.thelio-3990X>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
 <20240207-s390-lld-and-orphan-warn-v1-3-8a665b3346ab@kernel.org>
 <CAFP8O3KHsjCWowDTBxOq7GQ3bdsA2tAMO5Y4YfKR374Dz_Z54g@mail.gmail.com>
 <20240214122055.6438-D-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214122055.6438-D-hca@linux.ibm.com>

On Wed, Feb 14, 2024 at 01:20:55PM +0100, Heiko Carstens wrote:
> On Mon, Feb 12, 2024 at 09:31:53PM -0800, Fangrui Song wrote:
> > On Wed, Feb 7, 2024 at 4:15 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > +       ASSERT(SIZEOF(.got.plt) == 0, "Unexpected GOT/PLT entries detected!")
> > > +       .plt : {
> > > +               *(.plt)
> > > +               *(.plt.*)
> > > +               *(.iplt)
> > > +               *(.igot .igot.plt)
> > > +       }
> > > +       ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
> > > +
> > 
> > It seems that arches that drop .plt typically place input section
> > description on one line. This saves vertical space.
> > It's shorter to use one input section description to match multiple
> > sections, e.g.
> > 
> >     *(.plt .iplt)
> 
> Yes, I'll change Nathan's patch so it looks like arm64:
> 
> 	/*
> 	 * Sections that should stay zero sized, which is safer to
> 	 * explicitly check instead of blindly discarding.
> 	 */
> 	.plt : {
> 		*(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
> 	}

Thanks a lot for changing this. I tried to be consistent with the rest
of the linker script but I guess there were not really any sections that
had this many lines to make it one lining it worth it prior to this
point. Stylistic expectations are hard to account for :)

Cheers,
Nathan

