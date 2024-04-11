Return-Path: <linux-kernel+bounces-140139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2848A0BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6686128118F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F814388B;
	Thu, 11 Apr 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jglRRx3v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925B5CBD;
	Thu, 11 Apr 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826499; cv=none; b=hEJAxpSfx9u/Ohhl8sLGIcFzOfTu+8Zv66bHSlPqZjpwtYbJzS3R1YUalI6o/aoQ8KB0DNXsZR0nad6TyBG7VR5Cg8rsow5A+d24xiGN416i6mbgagilUvlnR6c2tsSJ0g0PBiaj4eM2+pWoX44VWDXRBz6rr3yeRCqlWrLWimg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826499; c=relaxed/simple;
	bh=CjcEJ0njrZnjfmJLychiyJIve3HrhAs1E1Yd0lbqPX8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h1elkL4WYWT/J5Bd0ziKs3XVvmzVHsrrMjUTSjNPU7mQsz0mRNxmjj3CzaJ6kXA7ss9x4LqUou9kIoaJ7Pqsh5JjpRQ/EPjZi4ZDGbVYs83lgPmcRwfBMU34FXYqo1oqAe3JivhAkSK8r7P0u67nYOPlk4XluLfyZ+Vw0EbXMjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jglRRx3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4758C433F1;
	Thu, 11 Apr 2024 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712826499;
	bh=CjcEJ0njrZnjfmJLychiyJIve3HrhAs1E1Yd0lbqPX8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jglRRx3vOSXQJb0OkdxmIXoAuCtyWLgOOfcfIa95LLpPJA33iWAItDeq1L7t78b6c
	 /AHcP7LNCyKxiK0JxoJZ5uJ953br2VKRU8nKF+aWF1wJDfBbIW9QnFnoE4B7+kEO5l
	 G2RB4bhL4SpBBJyy1rPSOVjSaLKHp9fJzvP2OtVOl3x0EKk0S/AAtd0dZamiQCPuxR
	 gU0jnQRhDAaoBM0ztx5tBm5FuemoJPT3LCUMriBrCn48rrvcV0auKTXK5rFx0RG5U4
	 8OynzgcfKs89uvd5iElRC2AyYtAKfF+W6p48eetDeu9QyrqjrM53lRvBSxJEKHU0op
	 G0vGlMXmvv1NQ==
Date: Thu, 11 Apr 2024 11:08:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: bpf: fix hid_bpf_input_report() when hid-core is
 not ready
In-Reply-To: <20240411-fix-hid-bpf-v1-1-4ae913031a8c@kernel.org>
Message-ID: <nycvar.YFH.7.76.2404111107370.5680@cbobk.fhfr.pm>
References: <20240411-fix-hid-bpf-v1-1-4ae913031a8c@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Apr 2024, Benjamin Tissoires wrote:

> Reported by linux-next:
> After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> x86_64-linux-gnu-ld: vmlinux.o: in function `hid_bpf_input_report':
> (.text+0x1c75181): undefined reference to `hid_input_report'
> 
> Caused by commit 9be50ac30a83 ("HID: bpf: allow to inject HID event
> from BPF")
> 
> I just forgot to put the indirection in place.
> 
> Link: https://lore.kernel.org/linux-kernel/20240411105131.7830f966@canb.auug.org.au/
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Please also include Fixes: tag.

Thanks,

-- 
Jiri Kosina
SUSE Labs


