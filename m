Return-Path: <linux-kernel+bounces-128357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883478959CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2861F23306
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A7159211;
	Tue,  2 Apr 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax40I7s+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75036158DDF;
	Tue,  2 Apr 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075658; cv=none; b=IHk0TwbJjAqL2zOh2h9e5GzmroBEoEiAijhHNke1vt/SCXs4isyya1XxvXOwnWih90B21l3teel6ZIy2K8uz8hZVJL91OI/O/SA8Ns7Qjw5IlsknuTNZqSlvgrqeVDojcky25OOLIOeG1SdP/BprRdB39qzdoNikeRGupLPJ8CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075658; c=relaxed/simple;
	bh=Svne5px183q/ma/JOmb0g2/K40TlcVO4eSYEAbAnKm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y84WJpYN5Ob7t9qtZjBpH7VYgGm6yGM2+yOLyrXzomWWyjj+qWNc/BjDP3TJWdgo4u0DwwFklY7qjtQEV6g1KIgSh5ChS+zYutW76HywL7vIJ48nBpBSe3hmRKfjaoowFdSmvyWYgim38CsVzuvACv2yW1DCSy/m+Lz0XkxmSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax40I7s+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF44C433F1;
	Tue,  2 Apr 2024 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712075658;
	bh=Svne5px183q/ma/JOmb0g2/K40TlcVO4eSYEAbAnKm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ax40I7s+AkvmPaYvUo9rYnFX/xcIuWaUX+3xcvAI0RbSOr7aYRP4XoIXH4sLs7KTZ
	 O5iW52kNqULgoZj9yW6X/lSiKzjx9HIQzFMtfhEfDmRWN31ImCV35nselv/RtgSizb
	 RDuY8ofx8yT+m8X0UObp+7TBHaiLG8jyZLQkFc6oiZBaTJ+Nhf8PDcHnYfMWm44hPo
	 hvpysLWqU2ParLFqfav7zF5Rzy8xMhzvfcQ+TYMnkXSiwzmAlpe2yfcU4nIPGKl4aV
	 jMQZWgc2cRW77xbYf901540+7N6P9JKC+VfS45GmYSm8EppwY8gNPMVk8TPxKJrmpM
	 CMxZz82nhQ7AA==
From: bp@kernel.org
To: thomas.lendacky@amd.com
Cc: ashish.kalra@amd.com,
	bp@alien8.de,
	bp@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	michael.roth@amd.com,
	x86@kernel.org
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Date: Tue,  2 Apr 2024 18:34:12 +0200
Message-ID: <20240402163412.19325-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Borislav Petkov <bp@alien8.de>

On Tue, Apr 02, 2024 at 10:54:50AM -0500, Tom Lendacky wrote:
> There's no requirement from a hardware/RMP usage perspective that requires a
> 2MB alignment, so BIOS is not doing anything wrong. The problem occurs
> because kexec is initially using 2MB mappings that overlap the start and/or
> end of the RMP which then results in an RMP fault when memory within one of
> those 2MB mappings, that is not part of the RMP, is referenced.

Then this explanation is misleading. And that whole bla about alignment
is nonsense either.

> Additionally, we have BIOSes out there since Milan that don't do this 2MB
> alignment. And do you really trust that BIOS will do this properly all the
> time?

I don't trust the BIOS to do anything properly.

So why isn't the fix for this simply to reserve the space for the RMP
table to start at 2M page - even if it doesn't - and to cover the last
chunk *also* with a 2M page and be done with it?

Not this silly overriding dance.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

