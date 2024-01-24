Return-Path: <linux-kernel+bounces-37634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A839783B2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED0F2846F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAE4133428;
	Wed, 24 Jan 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUPbhXK5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B7132C34;
	Wed, 24 Jan 2024 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127121; cv=none; b=kXsmRSnRtAvmspRdVn2DHDO95WPyIzR5utZ476iv1ZXAnn0x0qCeXVxxLL28Re2F8HtVwOTkRAE+Nus5MtQi1cQlzKvkZ+qDkJxr1SXGBWDeeGi6okIJdqaMUgCv89Y5WM/3NijR3UMX9L+DOnuprOyVAgoLuEiUsiDGLsHLfX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127121; c=relaxed/simple;
	bh=qo/3eNjmjaoMG9zwXqD4ctthMqQfCwIUP9IKci9GP9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbFv/WcOL6MLo72YvV3v+DGyw/zUM+BOMNMkVBtWDlq4xV/Y3UQqfNb/FkKWpEZH+SmmS00zJkGjXrrKDe81bYV9zorFe4ykmWBJNVqLg0dRdjKOF53XsNLnCsm3W3vGbHrj3z8bQN6qD7eiJGGMq8LlRexTsIgLhPxusjYBTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUPbhXK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119AAC433F1;
	Wed, 24 Jan 2024 20:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706127120;
	bh=qo/3eNjmjaoMG9zwXqD4ctthMqQfCwIUP9IKci9GP9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUPbhXK5G7Iq2+auao2mCkK6+72UN4/PkBfXpJwx+k5feoskqm7/6YM4sM7o4uS7B
	 XedFl3PM5P7/cykPJfIjKHL78nOn/3biVqkuhWqxMZZn/wQ0UNAjXYukW/M8nXub7S
	 7Fqxr2WuW1MNFZpw6oGlh2ReUYVU5wRewNqg1iZkEH3ct68dP5gK6+NPRz6Xyc40gb
	 mhPCq+BKOc2pC3jIkX2guAIcXA4WHCOdtArn5XURYaIWVh1rHJQkIRUqz9a3ppDaDo
	 CcQKYwUJrES+4nFBemX+SBvjXmcPFF6H+kB1Lbt+eRqt67mYG99gwaoxx40L66o3b+
	 j6ohuOS/LVmgA==
Date: Wed, 24 Jan 2024 21:11:57 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] tick-sched: Preserve number of idle sleeps across CPU
 hotplug events
Message-ID: <ZbFvDbFm1_EfajFf@pavilion.home>
References: <20240122233534.3094238-1-tim.c.chen@linux.intel.com>
 <87v87ijzqj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v87ijzqj.ffs@tglx>

Le Wed, Jan 24, 2024 at 08:30:28PM +0100, Thomas Gleixner a écrit :
> On Mon, Jan 22 2024 at 15:35, Tim Chen wrote:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71fee48fb772ac4f6cfa63dbebc5629de8b4cc09
> 

It's a different patch :-)

