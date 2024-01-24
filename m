Return-Path: <linux-kernel+bounces-36297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF078839E91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70581C24347
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7891C16;
	Wed, 24 Jan 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZvkooMNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916D1841;
	Wed, 24 Jan 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062227; cv=none; b=BmF7T3Vwa807fD9ikpNoezlblY+EIeWWq8dCbKosqVHhEnoEwblu+vilIoCIUAUV7868EJiTpf7+s9dqB8wVrVerJfzPEyReiTyRNZVLUrkepXo13EuwpdyJk967aXRt3SOfuKpH+wa0/KoiEq6WFYQD0ol+n9DqSyta44o4tKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062227; c=relaxed/simple;
	bh=gFGMJyOuzOpF0pIGpBslSgyUmphJ1xTgUb29Bgc5P8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/3ziedauRK3HN0G8bzMdixNoovhgHgXqasFCo1n8zUWoYYUDkPJAXRrWMXWEGWqjVlR64VqukPsvx/c+p+GwmXPiaC2g+vvkWQWohUrfQCM8zGJ6k5/y+WFBBqcV39s/hIeVWxv7Vl7KrJxiynEsv33CHDKud5s/POCDy7NgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ZvkooMNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE788C433F1;
	Wed, 24 Jan 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZvkooMNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706062223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFGMJyOuzOpF0pIGpBslSgyUmphJ1xTgUb29Bgc5P8U=;
	b=ZvkooMNQ/LGhCaagSgTLjz7lLBLZAp1/Fj5XpxYn++1n9yNmeZuJpFFdVxhTxDx5JDI/8y
	qj7qZlsEdkF6fEWml/l97M1ghc8tKrKOGCrIuztbo6dIcX94mRgg1T/bwN4HV4SU3Z+dug
	1ujVcPRGZ/b9POBO8aEZzBmz8Wz7pkM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b66879e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 02:10:23 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60036bfdbfeso15166667b3.3;
        Tue, 23 Jan 2024 18:10:22 -0800 (PST)
X-Gm-Message-State: AOJu0YxpLBe2kLbFyKO8JM7dIvWA0msUFMJGon9Ygg3ccAwn4wq5j1uF
	bM2MaxGb178p9rvKbz9gQOuOxOe+CPJXjuRisinrDtNZhHBpPCU9WcGAdufmxXM5QSuDRBefKtH
	W2NGJXDj4k/UKQHQeZvkfIYE9mp0=
X-Google-Smtp-Source: AGHT+IHqemWP6PnspjenWhThiQg0qQvviOk56jPT2q9KVGAxQyP6jBRvUyVpLCsX3u749XlsBHcpUe+U00BRKfgx21Y=
X-Received: by 2002:a0d:d68e:0:b0:5ff:6552:8f57 with SMTP id
 y136-20020a0dd68e000000b005ff65528f57mr141897ywd.39.1706062221341; Tue, 23
 Jan 2024 18:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124130101.428c09a3@canb.auug.org.au>
In-Reply-To: <20240124130101.428c09a3@canb.auug.org.au>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 24 Jan 2024 03:10:09 +0100
X-Gmail-Original-Message-ID: <CAHmME9o-DpMb7bCg=WJy5pfMpCQh4ZGHOYu4-s-nU=925Y4mwA@mail.gmail.com>
Message-ID: <CAHmME9o-DpMb7bCg=WJy5pfMpCQh4ZGHOYu4-s-nU=925Y4mwA@mail.gmail.com>
Subject: Re: linux-next: trees being removed
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Hector Martin <marcan@marcan.st>, Jean Delvare <jdelvare@suse.de>, Lee Jones <lee@kernel.org>, 
	Micah Morton <mortonm@chromium.org>, Mike Marshall <hubcap@omnibond.com>, Pavel Machek <pavel@ucw.cz>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

Branch updated on random. Please do not remove.

