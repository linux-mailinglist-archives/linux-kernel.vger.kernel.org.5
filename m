Return-Path: <linux-kernel+bounces-140205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098A78A0CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8811C21BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C3145B10;
	Thu, 11 Apr 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/vfrxqu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196D7145349;
	Thu, 11 Apr 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829117; cv=none; b=KbVEpb3+8lDOkv+fE0QOb8+XgSHq+TJIV2efK33zgr2L0ygDPao/DgonypXy//Ns84kEgywzWfd6tuwn/v5nJBjez+qgBR84gFOZf2lmrS4jkzGRJ0j6Ccntt0LNm1zYaTPHHAC/6/2YTDe7F2uGXH0XKh51vA7APnUn2YvZu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829117; c=relaxed/simple;
	bh=gT/UUq46+ZH0vsbo494KIoMOGzMYJiQPkOd5IBmTgEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIncgNXbSpBlw/qBN9OJN2V00TzJnsPdaetar0xorl8Sp79r9ZLQ+qmLbWqNXAAZ4Bfad9gZpoCTEfwl5FQ/aP85Er1lAx9tIQ1hB2yosd90c4lNyjXLIFyYT59mciXVhLvXPa0KD2LEwJn0VO3KBjWIZx4zy1MdMa3TGs/M/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/vfrxqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B656C433C7;
	Thu, 11 Apr 2024 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712829116;
	bh=gT/UUq46+ZH0vsbo494KIoMOGzMYJiQPkOd5IBmTgEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/vfrxquoSrBfLLtFX1I1HZL7eajm4G91r2NrPKwWhXEduTH9P3b0D3yx2IhiQ7cc
	 9f0cWcY9JzfPQzoB/LLv1i68u9RNbrzaafk+o3OJ8Mafrpc+XNga3lhxrZTlgiR/em
	 0ysmyXN2dnt11hyId/ZXqgcWMeGO8xPk4kA5zCY6cpNdnxFdyQ4yFc4oQwkYHilL94
	 dTRfH7vkgLYNSVHo0sKkBLV8B9UTv9m8hqbZ/0SUVRa7eZteEoZANJRbo6a7uXHdT0
	 10YoJU1pFflqgsTP6VGcp9EVLVAB5xi85QlG8y4IJIQUQI2g1WjcLZboT/6lxpoZxm
	 5buecev4qqAug==
Date: Thu, 11 Apr 2024 11:51:52 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: bpf: fix hid_bpf_input_report() when hid-core is
 not ready
Message-ID: <jdwmoghmwice2arahxdksjs224pssdtcfipxxrxhm3ujv6jfzc@n2s5nyiddjnt>
References: <20240411-fix-hid-bpf-v1-1-4ae913031a8c@kernel.org>
 <nycvar.YFH.7.76.2404111107370.5680@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2404111107370.5680@cbobk.fhfr.pm>

On Apr 11 2024, Jiri Kosina wrote:
> On Thu, 11 Apr 2024, Benjamin Tissoires wrote:
> 
> > Reported by linux-next:
> > After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > x86_64-linux-gnu-ld: vmlinux.o: in function `hid_bpf_input_report':
> > (.text+0x1c75181): undefined reference to `hid_input_report'
> > 
> > Caused by commit 9be50ac30a83 ("HID: bpf: allow to inject HID event
> > from BPF")
> > 
> > I just forgot to put the indirection in place.
> > 
> > Link: https://lore.kernel.org/linux-kernel/20240411105131.7830f966@canb.auug.org.au/
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> Please also include Fixes: tag.

Oops, correct. I'll add the following (in case b4 is smart enough to
pick it up by itself):

Fixes: 9be50ac30a83 ("HID: bpf: allow to inject HID event from BPF")

Cheers,
Benjamin

