Return-Path: <linux-kernel+bounces-99501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10AF87894E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8031C21247
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA456765;
	Mon, 11 Mar 2024 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEkPviPq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7054F95;
	Mon, 11 Mar 2024 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187768; cv=none; b=aARDD1M0+h2/tB8P4XZjN9H33sAneRa0uEH+g5r2vOYWpWdJvkioeCwBwazweA9kMiAV3uwaI04vNlMeAbHEg4hH4phK76v46goQ3jedA3N2y06IlsQQlE24UWlwdxuFg4BvK332cT7DYt/TBqPdwUuRCGzhyUHSI2gNjD+x9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187768; c=relaxed/simple;
	bh=rMv/IEo93hGWvO+dcxdINAvp+DT2JdcLL0XiT32U3XE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M2yp9qY7dk6hDpYYwfzLhMsITagaX16qbTSjQXRcrh4qqug1PZPBwWwHQBp7gU6e53j89yXrESqr2CE7PXN4FZiPj5m5eE0cPdVfdA7txOsVfry29Xy4G5JEhy81riRNqzVAI86EQuaUs2lmK02pU3gZfx0Oqx0YjLCi7XxY76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEkPviPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA00DC433F1;
	Mon, 11 Mar 2024 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710187768;
	bh=rMv/IEo93hGWvO+dcxdINAvp+DT2JdcLL0XiT32U3XE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oEkPviPqTzS0MunoGUWYVZ4vNTCu9OZn6+yQ1mTPisR8i+2LVEnHGkJ8TZkbgn7Zb
	 7JZ/hYVCI3Iss4qIBT+JLDCW0nzRCZoNDBo4GKlMW/tYU9IYwHvro4tXG957uFrMNc
	 zi2/P4NhcmV8UvStv1rPWyUMfGT1mG9G2L938J+GTZxCxs0FXNFY0r3p45mEw9sbDN
	 0uqSh+T6tl7twl6OL8hFZjvzezmtwgBH8lfT6PAiNu6Fc+1cK92LguzVJlXwbBazRV
	 86e6wFIqK2vA4t5An5p1twwadYfL0qrNZVYsWNKpc2VloMt7kABcwSTWZ0pXuN/6gD
	 vl7JhDb4yjh6w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Mar 2024 22:09:24 +0200
Message-Id: <CZR6YT6T2RS0.KKPTUAAVXMXF@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rnsastry@linux.ibm.com>,
 <peterhuewe@gmx.de>, <viparash@in.ibm.com>
Subject: Re: [PATCH 2/2] tpm: of: If available Use linux,sml-log to get the
 log and its size
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <mpe@ellerman.id.au>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.17.0
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-3-stefanb@linux.ibm.com>
 <CZNS7FO53BHK.6NO93P0C0VY5@kernel.org>
 <CZNS9K4BJPQ8.2MD4WZS8YMI3W@kernel.org>
 <663a3834-056e-4dda-99dd-16ee8734100e@linux.ibm.com>
In-Reply-To: <663a3834-056e-4dda-99dd-16ee8734100e@linux.ibm.com>

On Fri Mar 8, 2024 at 2:17 PM EET, Stefan Berger wrote:
>
>
> On 3/7/24 15:00, Jarkko Sakkinen wrote:
> > On Thu Mar 7, 2024 at 9:57 PM EET, Jarkko Sakkinen wrote:
> >> in short summary: s/Use/use/
> >>
> >> On Wed Mar 6, 2024 at 5:55 PM EET, Stefan Berger wrote:
> >>> If linux,sml-log is available use it to get the TPM log rather than t=
he
> >>> pointer found in linux,sml-base. This resolves an issue on PowerVM an=
d KVM
> >>> on Power where after a kexec the memory pointed to by linux,sml-base =
may
> >>> have been corrupted. Also, linux,sml-log has replaced linux,sml-base =
and
> >>> linux,sml-size on these two platforms.
> >>>
> >>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> So shouldn't this have a fixed tag, or not?
> >=20
> > In English: do we want this to be backported to stable kernel releases =
or not?
>
> Ideally, yes. v3 will have 3 patches and all 3 of them will have to be=20
> backported *together* and not applied otherwise if any one of them=20
> fails. Can this be 'guaranteed'?

All of them will end up to stable if the following conditions hold:

- All have a fixes tag.
- All have "Cc: stable@vger.kernel.org".
- We agree in the review process that they are all legit fixes.

BR, Jarkko

