Return-Path: <linux-kernel+bounces-118263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD088B701
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6FA2A73C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500EA1C6BE;
	Tue, 26 Mar 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="YvFOhEbf"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85640210E7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417391; cv=none; b=J9BBtEhM9jgh0mQqIkiQ0IcLQkOD0dY+PfwiCpZe0Dq9DBNN4OIC+bAIWGuO5+eNnBLcYJQ+4qwo1xwt86E1lH5Aipgdx9O2e3IJj6845ozwSqDmkx2FPtFJm6UP6nsjkl7KwBZUqs0Ntyh5hRYGfgGHl8W66GWr8iyqBnuLl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417391; c=relaxed/simple;
	bh=hvfXc3cBI2wusfotRhzl3KQZfpvrvW9p1GwV5HH0rEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH7ajaf/5repo8POu//HTaX0XOS6OWrjQkNnEXrfqS131VK0TE1XwZnnWLz8prhikfPEmO0VlVv3vOo/1lbjHQswfrLIQRcTGV0eZiivvfhDjJi2HkdyJURmycyjQtXT4PB672MDExeaqhhrNEwdfHL78IvZhgcV1krJ8O+knu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=YvFOhEbf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Tue, 26 Mar 2024 12:42:41 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1711417386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0g13RwPF3xDDXAEsdJoSVK6LMzTBFUkpC7KC8LRlI8=;
	b=YvFOhEbfrzGrlB9bK5ye/0l7uUBWSQR56tpoM8zLihmr4jjWBrvrqQll7TfC5vYSQj1qbV
	Rm5qztpTlIC8nSRVVCUuvFIjgTGTU9zj36PSdfje8AAwStrgRvB0msO9dcjhsilnHugnRQ
	0DEB5ZpBX6bpBJUJx+l6iO+ZfAed+EAWJfd/69PKesq0a3u2bWWJ19Ej4sUzvxHieUrkdQ
	ls8JOo6uXjLKKwpCbJnjcx+ADcjca44mHxLNoXyeWXpOcwOi641jX2MjDz9Z54IRa3alYR
	nIloX0CPS+NYc/50EtO0YBQKmOhpwuxz4sPh5CMWr6wpiY3YTEfYTy05v0p2Zw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
Message-ID: <ZgIoEYQrX1x2Fzu6@titan>
References: <20240224052436.3552333-1-saravanak@google.com>
 <ZfvN5jDrftG-YRG4@titan>
 <CAGETcx8+vw0Vr0NWzjOAvxAZ07M4U7BWPAgO9avCngW0-9e_kA@mail.gmail.com>
 <Zf7I65PiOR2wX1Uo@titan>
 <CAGETcx_=MmfgDajM16iJ4Of9Yr2Sy6ZpU=MyhYgnmOJFUTD_oA@mail.gmail.com>
 <ZgIZ4LmFOqdiDJBH@titan>
 <CAGETcx-Emvu41nB3UDnb4Gh2aJEKu_hFcHX89uWnBTnaqvpN8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-Emvu41nB3UDnb4Gh2aJEKu_hFcHX89uWnBTnaqvpN8g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 06:35:45PM -0700, Saravana Kannan wrote:
> Ok, I have a solution. Have the audio-graph-card2 find the fwnode of
> "multi" and mark it as "not a device" by doing something like this in
> the driver. That should help fw_devlink handle this correctly.
> 
> fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;

I'll test this out, thanks.

> Definitely do this though as a forward looking improvement. It'll help
> make the suspend/resume more deterministic and will eventually let
> things happen in an async manner.

Is there a way to also do this in the driver?

> -Saravana

John.

