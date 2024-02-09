Return-Path: <linux-kernel+bounces-59554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6284F8DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22319B2611B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7B7603C;
	Fri,  9 Feb 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9EqvZC0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745916BB5F;
	Fri,  9 Feb 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493774; cv=none; b=i2kcEgvYW5rSw//vsaSxQzjl+TKu5x6KuRaWAXitorOAuyg0nvewMypvjtE4qbxJhWDbPWHUBpQ7BQQpYPTA8xCA2D8osTYAdPOk76ArCJOZUEvP3goCu6MriyT5mRnWcqOGKW9CaZFOwm9f8t3G3wbdLrtr4VcvMIRbU97ABow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493774; c=relaxed/simple;
	bh=k7tvZPpSMb4OW245Ntd0Rp1l7PgO3EQh14sovzKs2KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeI9zK/guzWysIYEK31KwpS7qQH131zDAwXq2QZ/4FLBnbbyBGyYtwK3y+5o8HQxsnavDYJlEM3+UGLBRBLmZVBIVxzROLaaeabN9riRphYBDcfkJmEhTc9uHzZDzzyA5lW/a/nz2ZaWBHK+MUpaXyYaI+ZdRyewCg+x+16U5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9EqvZC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E1CC433F1;
	Fri,  9 Feb 2024 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707493773;
	bh=k7tvZPpSMb4OW245Ntd0Rp1l7PgO3EQh14sovzKs2KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9EqvZC0iA4Kv/hbjuw6jBQuIRftl6sMLovxy5DTLF4LYcmibxM6Mc0hD7xDhFvF+
	 bMhUaOGrQp5PSU/w1cI90oDUdG2D12J6p34JlK+SHIn6NSmptCck2YS3PytcWWwdkV
	 1mTbolst3o5WIUR8QyKnFLWPw4LQzw0HzzB6dUJzEsNc6RplfDW/30qytBNZEcQzAW
	 2TxdXa1lBcSsZShm89/0MQ16TbswhzEI3b0lHZJrKOy1ySEIq5ukRrsuI3SMLixdKG
	 JS98a06Of7nC6eP2f8XnGqHmYBck0Joo97kAFrBIQGNSFlNxv7e8qxCgB2cXatAT22
	 YgRYrMSHJp0KA==
Date: Fri, 9 Feb 2024 16:49:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
 <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209154305.GC3282@redhat.com>

On Fri, Feb 09, 2024 at 04:43:05PM +0100, Oleg Nesterov wrote:
> On 02/09, Christian Brauner wrote:
> >
> > How do you feel about the following (untested...) addition?
> 
> LGTM, but let me read this patch once again tomorrow, I have
> a headache today.

Bah, feel better!

> 
> > I've played with PIDFD_SIGNAL_PROCESS_GROUP as well but that code is
> > fairly new to me so I would need some more time.
> 
> Heh, I was going to send another email to discuss this ;)
> 
> Should be simple, but may be need some simple preparations.
> 
> Especially if we also want PIDFD_SIGNAL_SESSION_GROUP.
> 
> So the question: do you think we also want PIDFD_SIGNAL_SESSION_GROUP?

Thought about this as well and my feeling is to wait until someone asks
for it. Right now, we have a reason to add PIDFD_SIGNAL_PROCESS_GROUP
because of Andy's use-case. If someone has a use-case for session groups
then yes. Otherwise I'd just not bother?

