Return-Path: <linux-kernel+bounces-78448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5398613A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D065B1C21FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4843680049;
	Fri, 23 Feb 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEM1sfmN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3367E798;
	Fri, 23 Feb 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697463; cv=none; b=OA0Az2wcrZW2+MPa/BJLpynMJKvp2eQHE+Vps2rWE6TPUKcof0//Vsqe3CKLUYbSKzKu37t0w8vbN7t//ArnywOdn7WcmDCVQ+eaVEUl7XfdxDqUnreCCDxqcknVHBKG0tXJO6iHnF3EHM2Si5aCEkltc/sYEF9tYkpTmRQIqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697463; c=relaxed/simple;
	bh=v75Fs9X9q1QSBWVEqaXKpl9UZgm3FC+OfE2dPCm6xDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejrNQn9wD5ayLteZ50vvsVsecsG/rShEB/a1y3XFwYrNdrruR/fgl1xXAUC0rZVE7yXe1j6Ws0guyLRpuTH2Rn5Wgmx/+//Q9KhBsvUMP43kEjDzbbHvSf9sGlVdgICAdHOIQ+Up+tsv6ZMP/0Vh6lKKOA642Gi+frmTicSAyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEM1sfmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EACDC433F1;
	Fri, 23 Feb 2024 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708697463;
	bh=v75Fs9X9q1QSBWVEqaXKpl9UZgm3FC+OfE2dPCm6xDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CEM1sfmNXqk9FxBTGehsu+qSAzaTB9qX+Dv/4obdOrcBlqjJYk5v74qh26umjfyfG
	 BlntPfwZmQP6KusyG7Mdm2L6a8aeXe78f3ZU9pgsjlRh7nOqvPoYoZ4addKRD00Hhx
	 nvfYCpzCNB6afQzRtC9sPkh8nEXZg6CYLWTEjQ8NehTwRxonJz6hDBq62tqoj6YpYO
	 u0pyg9C/eo7W+iYX3pO4+X+1qy+C9GAquZaUi9ip29ujspIgpTaHiLlJkpcnk44XWn
	 A5Uq5VhJFv6gWlmAHmzuteDYZba9q/7f96EyEh5j/pAs9/d7zKx//q2592XRJfOcIB
	 vlefHloA61SCA==
Date: Fri, 23 Feb 2024 06:11:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 idosch@nvidia.com, razor@blackwall.org, amcohen@nvidia.com,
 petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com,
 bpoirier@nvidia.com, gavinl@nvidia.com, martin.lau@kernel.org,
 daniel@iogearbox.net, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: add local address bind support to
 vxlan and geneve
Message-ID: <20240223061101.6ab0d1e6@kernel.org>
In-Reply-To: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
References: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 21:48:39 +0100 Richard Gobert wrote:
> This series adds local address bind support to both vxlan
> and geneve sockets.

Looks like this breaks a lot of vxlan selftests.
-- 
pw-bot: cr

