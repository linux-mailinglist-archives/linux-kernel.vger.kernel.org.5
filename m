Return-Path: <linux-kernel+bounces-95154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C68749E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05C21F24171
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA48289D;
	Thu,  7 Mar 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6Qb+rAd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AEC657D5;
	Thu,  7 Mar 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800819; cv=none; b=aECOxRyzuOiwDiEu9lqoKqeFBv9BYcKJfEqds0n+DjTACvNM5riezYc6l/PjiWWz5Fw9Rk2p56vGvVDvTS17WGxHrrxRCUSwjmcf6KRDJWK0Hv2ugK6F9ogbUgo34wYyn4CagakN5vctYMOyU2bhcjLZmNwzqE/7bfIxrtcEp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800819; c=relaxed/simple;
	bh=ruvxBhPt5E6gAvEp7k33Gsr1p4H69XU+cVmoNjLZvFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E76XCt7zWWfD9rtxuBbX1C0I42I2xXSZ+lWuKPn+KA1WViuoh2IfxxSiB3/8yprnIi8dUrG73Yeb905+sKJntH5XOQAVbzdwOzHbFhKC7KwjGOtsnM4CnjqKUteBTJt0YHOkztp4mx3Qea6ijWOTUHjQkk2kEJiccIFylI0mrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6Qb+rAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198B4C433C7;
	Thu,  7 Mar 2024 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709800819;
	bh=ruvxBhPt5E6gAvEp7k33Gsr1p4H69XU+cVmoNjLZvFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6Qb+rAd1Z5sjC3wf/T1VUClaXzh6muwyahcdADPCchk1F3O3lbsACdncdq3e2kG8
	 rPtLcznbFdhHuLYEROehisYGeIIZaA4rqilOagZyq6u9ajqB4WWFIdps6MShW4D7Iy
	 GFWkI2uVUSOIyIWwgnz/FKQHsL7HH2YOvM5+hHxpydmGQ0TvPtbFjg6kU7q3Qg1sqQ
	 wxEyJzQiIJLFWl5CNw/x1WJyBNpVMz9JIcwpsVwtmbPzl+cnJmk17J17SjBi3Dzs6b
	 CI25b0HJm1FIGPbB4VDSf38kbiD8geOmWy+UbF8XBlI6kQw/KL34xnNiyYFxVt/ud2
	 ubxszuRIONuKw==
Date: Thu, 7 Mar 2024 08:40:14 +0000
From: Simon Horman <horms@kernel.org>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net-next] tcp: fix incorrect parameter validation in the
 do_tcp_getsockopt() function
Message-ID: <20240307084014.GH281974@kernel.org>
References: <20240306095430.1782163-1-Ilia.Gavrilov@infotecs.ru>
 <095ce1d0f2cd6771b30ab1d73ee6aa8e8460c7c8.camel@redhat.com>
 <e8b2287f-bf25-4a95-aef2-58067c893b4f@infotecs.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b2287f-bf25-4a95-aef2-58067c893b4f@infotecs.ru>

On Wed, Mar 06, 2024 at 11:54:40AM +0000, Gavrilov Ilia wrote:
> On 3/6/24 14:36, Paolo Abeni wrote:
> > The above is incorrect, as the 'len' variable is a signed integer
> 
> I mean, if 'len' is negative then after this expression
> len = min_t(unsigned int, len, sizeof(int));
> the 'len' variable will be equal to sizeof(int) == 4
> and the statement
> if (len < 0) return -EINVAL;
> might be unreachable during program execution.

Hi Gavrilov and Paolo,

I could be missing something obvious but it seems to me that this is correct.
Although perhaps we could try rewording the patch description to
make things a bit clearer. Here is my attempt at that:

   The 'len' variable can't be negative when assigned the result of
   'min_t' because all 'min_t' parameters are cast to unsigned int,
   and then the minimum one is chosen.

   To fix the logic, check 'len' as read from 'optlen',
   where the types of relevant variables are (signed) int.

FWIIW, I see four similar patches on netdev this morning.
It does seem to me that they are all valid fixes.
But if they need to be reposted, or there are more coming,
then I think it would be useful to bundle them up,
say into batches of 10, and send as patch-sets.

This may help with fragmentation of review of what seems
to be the same change in multiple places.



