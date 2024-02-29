Return-Path: <linux-kernel+bounces-86897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1B386CC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB3B1F230BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998AB1386A5;
	Thu, 29 Feb 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVv8bJf+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28FF13776F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219367; cv=none; b=eKO6bjFoJxymsyjD2eG2rGU2WuHnQDozMKNbPA2MKeB3KjWMe4TQLzlebHn72MUFyOOxI9XZCKLKcPHNXILJ3vkUvV+zZ8ruVlriVd/n+unei2uCIoPDTjqZyMXvYL2oSvn5DOzu5WsmFGhzrihoFp1JmfIx1M0GUqDpC9tLyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219367; c=relaxed/simple;
	bh=M5tYlHJqiKu98ugQTIytTFV0lJCmkjxpZ7krVLv0VxE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hEbFrilBqyYNoZOhEUjxJk1qcTOEsUb67BHbS9szggnc/EDgGhabMOZALtoBQ4LUamW1H73QGbeF1N7npycTbDBvC4H6Qyp87l/nPMZaVm3F96voZpH31PFgPzmQ5NJYs7TTvi2yk9rjHkaPO27F/h/F0ix7CemHKpeP14+saRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVv8bJf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D72BC433C7;
	Thu, 29 Feb 2024 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709219366;
	bh=M5tYlHJqiKu98ugQTIytTFV0lJCmkjxpZ7krVLv0VxE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bVv8bJf+9RIalLrYvHYD4n5kChaqJ52mya/6h90yQdiZQA4mVc0AH4RqA5nkTAb1o
	 FyNTQEMS7tXc+12CtulA/OpdPFkegRZUsl8ap8gmvzzVFOt3n/eEMvCbmIKIi8+SkR
	 YXLGt3iOYmv3UdX0t5i5GK9LO+w+ZcNDK+262Rp8XCS3n1VNPe8uJUwWemDhuxv/L1
	 bT5OpioVOvFpXRubon0rsC2V8m5tUzOEqVJNRvI5aKMcQ91iZBcxAj2ekTVF5K8ix7
	 RoWP8f7YlTXJk/dtcJpfPD+hYnzkBLoKd3RF+qZDKcGg8S7NFFEIUlZ91wQkK2sGVR
	 tHASwCcFREa0g==
Date: Thu, 29 Feb 2024 16:09:24 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>, 
    cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
In-Reply-To: <2024022913-borrower-resource-ecc9@gregkh>
Message-ID: <nycvar.YFH.7.76.2402291605370.4159@cbobk.fhfr.pm>
References: <2024022257-CVE-2023-52451-7bdb@gregkh> <Zdylmz28rZ-mCeiN@tiehlicka> <2024022639-wronged-grafted-6777@gregkh> <ZdytVTOgfvKBBvtn@tiehlicka> <202402271029.FD67395@keescook> <Zd8hPpP_6q_o8uQW@tiehlicka> <202402280906.D6D5590DB@keescook>
 <ZeA-281OudkWBhd_@tiehlicka> <2024022915-dissuade-grandson-ebd4@gregkh> <ZeBRZqJd5HAKaOfC@tiehlicka> <2024022913-borrower-resource-ecc9@gregkh>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Feb 2024, Greg Kroah-Hartman wrote:

> It's pretty trivial to get root on most of the "enterprise" kernels 

Wow, that's a very strong statement you are making here, and I'd now 
really like to ask you to back that up with some real data.

(or at least first clarify what exactly you mean when you are saying 
"enterprise kernels").

-- 
Jiri Kosina
SUSE Labs


