Return-Path: <linux-kernel+bounces-163289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7D58B6887
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902B41C21787
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB41094E;
	Tue, 30 Apr 2024 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fONoB7k2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231910A01;
	Tue, 30 Apr 2024 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447555; cv=none; b=FteiLt9koCJykm5wYbLoFjgANLfx9zvQavjAaXyCmSg53vz2K1WGaxIeRiLjwT6xHPz+86yvUS/Yv4H9hpdahcC47uzssyE12Ge5zaxRrqQCoYk6e8Iu7E42aUW8mcYDRhAWEy6UGcQnWK/m1wbEsCKXU1DbuZjWwyGc0Rjd6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447555; c=relaxed/simple;
	bh=Myy2TYiM6lGfQ8ob1vcPSh6RiLmkB4E7G0Hi8kZPG7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4RyxUHDmtRM+M7KINuTeDF7NyTKN0epNvQKd0Ep9zbsyA3qrgiBiyJxt8VtEtgkpzpxrFpf/+7o2kLBUtaM7TETilcw4S9hV7Ot5+fNojiDTst62t4xEokL4tHNdWsbD/96fIYoRB5bCPvstcB4xYK5pkwfqHh7dLmxkY7RxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fONoB7k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E64C116B1;
	Tue, 30 Apr 2024 03:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447554;
	bh=Myy2TYiM6lGfQ8ob1vcPSh6RiLmkB4E7G0Hi8kZPG7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fONoB7k2s7G9UVQzAuakPNq4wiT9++KqENTcufeOoDyZqWb0/PMBScqWrdQJE3kxl
	 BATsB3L6s59oVDENCG7h182oXcNxqI5dSErrkYh5wzBfpOLESgaoawaziKUEhCYEGN
	 0Y3RI4U9PKYD8AmKmpjyNbXtJZTosPdQLWwIqKXUX8AaI2znRnRuYi9+ApCgEZi4to
	 QITVYC3O5sLSTa4kpiJHmTdI7OFuv0j0tkDSjKbbZa+BZkOaTAnj8mUDA4Lrw/rwQ7
	 yyUTfjfgDwZdwqCVlQ6f/+1z1/HHaao9VtbDd7AwQwxq/0y+lBikRTgnrddfCccJWj
	 TXs1kM57/g1/A==
Date: Mon, 29 Apr 2024 20:25:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next v4 6/6] net: add heuristic for enabling TCP
 fraglist GRO
Message-ID: <20240429202553.28c74569@kernel.org>
In-Reply-To: <20240427182305.24461-7-nbd@nbd.name>
References: <20240427182305.24461-1-nbd@nbd.name>
	<20240427182305.24461-7-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Apr 2024 20:23:02 +0200 Felix Fietkau wrote:
> Signe-off-by: Felix Fietkau <nbd@nbd.name>
       ^ 
       d

If you have to respin - please update.

