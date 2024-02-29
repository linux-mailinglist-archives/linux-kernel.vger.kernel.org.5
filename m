Return-Path: <linux-kernel+bounces-87181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB4786D0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198BE2862D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000870AE9;
	Thu, 29 Feb 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suixx2L4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A76CBF7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228171; cv=none; b=Yh/7s3k/4P1cTc59HaQ1Ly/xaE046PNwYLNYA2ppQ1N8DxQItCBUiMFn0o9YosGHc1tGuTe8s3vSlxmKiESV7ugwNGtpy+GWx4tlWpWSy7SOekki8mMyOiVN0NyQNa20FqvAmvgjX4tQtCMtnJbHg3UUWUDoD4OeDJm0+iYCK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228171; c=relaxed/simple;
	bh=WY258aooFcn6qkOL8EOxbiPNPHe9qPg7WdqKjI+2Wew=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dIXEzKxtsi4cG5UmiuEXhgDzqhe/zDV6PgPD8weWU7bXv5PdTJFHZT5uF1yFLO4c31qQW77xVvNVePOA5quHCi2OjEsGu+UhyAlPVguLhA+0kjKDlBB0f4NmbnfyRfjQ/EGSA+vEs0aday81U2hQcyAWVaTb2HIn239uIuzsoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suixx2L4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD502C433F1;
	Thu, 29 Feb 2024 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709228171;
	bh=WY258aooFcn6qkOL8EOxbiPNPHe9qPg7WdqKjI+2Wew=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=suixx2L4mx4+4hvxNg+sgRGiE1JQweXRpT+BnNu/4KEBfmwJJ2J6ozItvGiD2aNN1
	 JxWJzFTVleHV3LJicAMTYt3Oz/p9TZTeFO9q+NUU2UlyWlYbG6nw+6hTw7IlCH0phf
	 4jrEtmxwxk/qYkTmAtkI3dyr7sZfM2hPu5VYY5TIdE6rdxUG58jYLO3dLyCcRcugbF
	 x1KGJueMT+KXnx/rrnGVFtwE/S4suyovkAmVKgWnnxUEESNqFVQmR7CcGEHOfJhfz3
	 37A5CnVdKhIXyFcrEqRJAToRtQSfl/TlGBBnu0m7rAOv44qi0bIV8Hq/hS0Fr8zWl7
	 6h1Yg+6G02Sxg==
Date: Thu, 29 Feb 2024 18:36:08 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Sasha Levin <sashal@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>, 
    cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
In-Reply-To: <nycvar.YFH.7.76.2402291754020.13421@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2402291824020.13421@cbobk.fhfr.pm>
References: <2024022639-wronged-grafted-6777@gregkh> <ZdytVTOgfvKBBvtn@tiehlicka> <202402271029.FD67395@keescook> <Zd8hPpP_6q_o8uQW@tiehlicka> <202402280906.D6D5590DB@keescook> <ZeA-281OudkWBhd_@tiehlicka> <2024022915-dissuade-grandson-ebd4@gregkh>
 <ZeBRZqJd5HAKaOfC@tiehlicka> <2024022913-borrower-resource-ecc9@gregkh> <nycvar.YFH.7.76.2402291605370.4159@cbobk.fhfr.pm> <ZeCsKGwU96sKi_S_@sashalap> <nycvar.YFH.7.76.2402291754020.13421@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Feb 2024, Jiri Kosina wrote:

> - you pointed to a fix for UAF in BPF, which definitely is a good fix to 
>   have, I don't even dispute that CVE is justified in this particular 
>   case. What I haven't yet seen though how this connects to in my view 
>   rather serious 'trivial to get root' statement

To elaborate on this a little bit more -- I completely agree that this fix 
is completely in-line with what Kees is, in my view, quite nicely 
describing at [1]. You pointed to a weakness (for which a fix *is* in our 
queue), sure.

But I see a HUGE leap from "fixes a weakness" to bold, aggressive and in 
my view exaggerating statements a-la "I am able to trivially pwn any 
kernel which is not -stable".

[1] https://lore.kernel.org/all/D06F40E5-0DBC-4FF2-BAF5-2373BDF3815C@kernel.org/

-- 
Jiri Kosina
SUSE Labs


