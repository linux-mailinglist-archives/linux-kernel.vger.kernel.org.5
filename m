Return-Path: <linux-kernel+bounces-34175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C2B837520
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231581C2649A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90C47F72;
	Mon, 22 Jan 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SaiTxQdK"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC047F5D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958181; cv=none; b=bn9CnEQCw6a7Rt1/04f5xIi3dy7lbqY9J9gruSTauznuH5CaS96ahx+FjoNKk1PArCBp8UdPqMS+6YFg3OSnm3RRfECInoOqyKGJv6mdnjxPjC1u2WUahMWr4GZ+6q14wzQ8UighFQ1VSYHp3qvuDZ/U7el95q4hNY2M0zmO4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958181; c=relaxed/simple;
	bh=zMXc6tor4fJWUFbxItJ2+5r+CRBPP2/dvta/6uILgnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tnh6jFNDyLUKePzF8MzzFSZFIwTXg5yPRGEwuEK4OdGmpl++trzD6XjK0eTwFbJTN/gtYab/wlq7cYZXU6nWIggWnz6L4Y5jrc+9XhMGFtpCYQhl1X0hV7k7SygRq9MZ8C/QaK0opwETWeQWHf4H4tdDfG/dem65CCCkSbKwWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SaiTxQdK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d71e184695so13023865ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1705958179; x=1706562979; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK/doAZyyGzQuUQ64pMN/IegoB0Y5GZJ/6bMRTJUZOs=;
        b=SaiTxQdKSvdfDHf7FsAVB4Up811/prozfadikTlsZcpgqyu//7JGkD7lZap1WTv3/3
         zpsWEw/NFgolwwJgdoS3CQWtu6WWaltSUmnndO6I1eDYlP4mLNvPCOQ1U/7X2VPOVZCg
         mITcET3n22GHWVgtPIu4buWcJiSXEc5lOA120=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958179; x=1706562979;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK/doAZyyGzQuUQ64pMN/IegoB0Y5GZJ/6bMRTJUZOs=;
        b=tx8TEE/9oIvuPAKvHrAOlzFmCesKj6WK6IjlHsjtUqOQqUhv4w8P0XHmBbNSIetJuu
         V8tzcWBRboxFfBKet05YIDFiMJdmeRpjBaBpe5o6qXOMwnHG+YUwcCffTbJRrzJkd2Ef
         loGicm9MDdOwLmsNuC/gYjui8UYZmtS08h/15aGmUv474sl3i7kefC8IQpZy4wdyMWY4
         8i7P6lMFCIfpm42U+nZ3NuMZ2EKbcRCbW4smxiJ8xwn7tLXGJKiDQonKWahqZ3F509Y6
         DknhyRIFKAzgOn5f2hawdjwIGgXK/5+1VAI4NTx8Z8d4tDDF+Wy9l7smP5LnVlYsw8lv
         BEAA==
X-Gm-Message-State: AOJu0Yyc+kFc0Omo9ZnOteI3ko6yk0Cl75ptIWXUj7TPvIxN7Bw0/vA6
	82HaOJAPUlzZSKhqwfElJRdy64l0QV9azw76lA/9q6UnguKM+MQ72cIfcVgWAGc=
X-Google-Smtp-Source: AGHT+IHY6QTp3+L73kbC1yAy2VNJUlYykSfBPUTr4schnUh02OhLk1d1DJUhybB11UylKM92YKo7RQ==
X-Received: by 2002:a17:902:e891:b0:1d7:599d:ed25 with SMTP id w17-20020a170902e89100b001d7599ded25mr1272345plg.39.1705958179526;
        Mon, 22 Jan 2024 13:16:19 -0800 (PST)
Received: from fastly.com ([208.184.224.238])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902b28400b001d720c7ed48sm5693728plr.286.2024.01.22.13.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2024 13:16:19 -0800 (PST)
Date: Mon, 22 Jan 2024 13:16:16 -0800
From: Joe Damato <jdamato@fastly.com>
To: Christian Brauner <brauner@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org
Subject: Re: [RFC 1/1] eventpoll: support busy poll per epoll instance
Message-ID: <20240122211616.GA1244@fastly.com>
References: <20240120004247.42036-1-jdamato@fastly.com>
 <20240120004247.42036-2-jdamato@fastly.com>
 <20240122-erwidern-erleichtern-8a04080a4db3@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-erwidern-erleichtern-8a04080a4db3@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Mon, Jan 22, 2024 at 04:25:01PM +0100, Christian Brauner wrote:
> On Sat, Jan 20, 2024 at 12:42:47AM +0000, Joe Damato wrote:
> > Add F_EPOLL_{S,G}ET_BUSY_POLL_USECS to allow setting a busy poll timeout
> > per epoll instance so that individual applications can enable (or
> > disable) epoll based busy poll as needed.
> > 
> > Prior to this change, epoll-based busy poll could only be enabled
> > system-wide, which limits the usefulness of busy poll.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> 
> This should be an ioctl on the epoll fd, not a fcntl(). fcntl()s
> should aim to be generic which this isn't. We've recently rejected a
> memfd addition as a fcntl() as well for the same reason.

OK, thanks for the review. An ioctl makes more sense, I agree.

I'll rewrite it as you've suggested and send another RFC.

