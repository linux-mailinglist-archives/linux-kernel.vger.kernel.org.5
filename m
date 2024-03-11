Return-Path: <linux-kernel+bounces-99508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45EF878968
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0A1282135
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD056B74;
	Mon, 11 Mar 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts5HPB10"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367C56B70;
	Mon, 11 Mar 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188734; cv=none; b=Ioe9LVk5pON3SnyEnclqvlcSECzzIoJW4kbKhukEQAKf03uwQgmt0G2oL2MkpHoZsKA7FYTy+hGNvtm/PGA5800zpJ1zMKdbMCepbHAH84ZnGI7c3sXAiwc19P2uJs3eBaWkv8+hPWwPEDL4DrADvCvB44HCufv+9f356p3JwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188734; c=relaxed/simple;
	bh=g7a7Yd9Z2FNA7ZNNxwAmkonp9MHBpjW9SwXw2aB1x7Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PGDrYwl8x8TY/xGCvOs8mBuo0bV72woGYYjrVmlRe8wKG3vgyF6zVq0uvelUTPFJq8JhGHOAUqeBbMd5MfgGA/+++Jb7xojZ1umRAmr6L1Z23aFDGrccOCYZaismeYQKopSisKXN7zHs7xDbJwO2TtVYQhdYhM1qio7h1O1Ovpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts5HPB10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E112C433C7;
	Mon, 11 Mar 2024 20:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710188733;
	bh=g7a7Yd9Z2FNA7ZNNxwAmkonp9MHBpjW9SwXw2aB1x7Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ts5HPB10Yzocx5ksgB6BXT+IQ91RE0lxy/Cn2rVAmOfCBeg1JKO5qMbDb59q2M/d6
	 7lOpz73M9iD2r7KBDgSDjbZocgUADPNWhV9Z6CVLLZewE/zuSv91vYPvxcnRgL1XTC
	 rrGy4QHmapS9zrOo6HwBcHMdbP7c0HefCb50lcU5OZQUVqM/PlXmppxU1eGSwZSUbb
	 rKZTD2wjH1vbWvjtiwxSYxMJNnOokgfaqny1AZPdP1ddomWqh1pzICw7ZmOYTZHQwG
	 9+FG36fiYbDDofOFM4Q/j7GYyLLoTFBxlP3CFjPOZV0a5wAoABPzGegBxJzO8T/6ap
	 nXVQlxNEktOrQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Mar 2024 22:25:29 +0200
Message-Id: <CZR7B45P71XS.53XNZD9FWZSL@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rnsastry@linux.ibm.com>,
 <peterhuewe@gmx.de>, <viparash@in.ibm.com>, <devicetree@vger.kernel.org>,
 <jsnitsel@redhat.com>
Subject: Re: [RFC PATCH v2 3/3] tpm: of: If available use linux,sml-log to
 get the log and its size
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <mpe@ellerman.id.au>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.17.0
References: <20240311132030.1103122-1-stefanb@linux.ibm.com>
 <20240311132030.1103122-4-stefanb@linux.ibm.com>
In-Reply-To: <20240311132030.1103122-4-stefanb@linux.ibm.com>

On Mon Mar 11, 2024 at 3:20 PM EET, Stefan Berger wrote:
> If linux,sml-log is available use it to get the TPM log rather than the
> pointer found in linux,sml-base. This resolves an issue on PowerVM and KV=
M
> on Power where after a kexec the memory pointed to by linux,sml-base may
> have become inaccessible or corrupted. Also, linux,sml-log has replaced
> linux,sml-base and linux,sml-size on these two platforms.
>
> Keep the handling of linux,sml-base/sml-size for powernv platforms that
> provide the two properties via skiboot.
>
> Fixes: c5df39262dd5 ("drivers/char/tpm: Add securityfs support for event =
log")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

I'm worried about not being up to date and instead using "cached" values
when verifying anything from a security chip. Does this guarantee that
TPM log is corrupted and will not get updated somehow?

BR, Jarkko

