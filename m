Return-Path: <linux-kernel+bounces-96153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1038757C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E27F1C22799
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8629137C30;
	Thu,  7 Mar 2024 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB5ihk9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A939136995;
	Thu,  7 Mar 2024 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841615; cv=none; b=KqAGhqdSwKaJ4rCz6KQOwMLzBwBn4MFBTz1EcA+VpSWte5uqWG/z0JsSwphDsCblmA0tulWgHzNELjsXp8i+P0bBgZaUubbwAShkdI4UA9sVNXcPhSdIMnUgpkiV8gMc1QJccQE63eCd5wgvDAo5alB5c1WHaVHQ1t7ucqFeBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841615; c=relaxed/simple;
	bh=hHVUKE05J5hWZW3aCoiEn6Z8Rlg4XXsS0ZJFK6atvm4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=MjRWONakNCwbKnVrgn7GurO2as6U6GcBEDear6nJbHxWqSR7Kc923IcUDEyW363dO9Su1OrP8Gf8b6IfkHF99FYrd65xP0odKjdzOyBBC3V5sXcTTSOoRiqAhKDrwTWNKxhcqBg3fOIh9YqvcrTpaZ6H70T9UzlqJ24ihtxkzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB5ihk9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6863C433C7;
	Thu,  7 Mar 2024 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841614;
	bh=hHVUKE05J5hWZW3aCoiEn6Z8Rlg4XXsS0ZJFK6atvm4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=EB5ihk9xAs3LimzpDSuTx86WiERojQbp6l23Uruma8ryd5emdLC6GWdpaR/Pah6Gz
	 /nJx8NvseHYj6MPnjrjQ2vZsPXw79kBh97MIb/YkzvIP6XmALSmqwGWVizRc2ZCe92
	 z/VEbsToQl+nqJXgdl583vnahIVoUG30MGmRa3vdDd9HMPEtDPdEDlTOvDvrxYfNNm
	 alCJZBe08I1sunPYH/WVQIjuoZxJUjNC33lThq85LUus45sPfI23YzduxwNeM3c+LT
	 AKaiszpmyG7d/TIQMaCS95CjLDMFyjDR9pxg9EkaRLwrtIAUqpp7+Ai/1ADAC/b2RV
	 X5et78TkappFw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 22:00:10 +0200
Message-Id: <CZNS9K4BJPQ8.2MD4WZS8YMI3W@kernel.org>
Subject: Re: [PATCH 2/2] tpm: of: If available Use linux,sml-log to get the
 log and its size
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Stefan Berger"
 <stefanb@linux.ibm.com>, <mpe@ellerman.id.au>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, <rnsastry@linux.ibm.com>,
 <peterhuewe@gmx.de>, <viparash@in.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-3-stefanb@linux.ibm.com>
 <CZNS7FO53BHK.6NO93P0C0VY5@kernel.org>
In-Reply-To: <CZNS7FO53BHK.6NO93P0C0VY5@kernel.org>

On Thu Mar 7, 2024 at 9:57 PM EET, Jarkko Sakkinen wrote:
> in short summary: s/Use/use/
>
> On Wed Mar 6, 2024 at 5:55 PM EET, Stefan Berger wrote:
> > If linux,sml-log is available use it to get the TPM log rather than the
> > pointer found in linux,sml-base. This resolves an issue on PowerVM and =
KVM
> > on Power where after a kexec the memory pointed to by linux,sml-base ma=
y
> > have been corrupted. Also, linux,sml-log has replaced linux,sml-base an=
d
> > linux,sml-size on these two platforms.
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> So shouldn't this have a fixed tag, or not?

In English: do we want this to be backported to stable kernel releases or n=
ot?

BR, Jarkko

