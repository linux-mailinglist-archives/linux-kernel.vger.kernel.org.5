Return-Path: <linux-kernel+bounces-61887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03C8517DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7292E1F229B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F663C47A;
	Mon, 12 Feb 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3ajAkcW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930B3C087
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751433; cv=none; b=cGNAAOk/VMp31FsQgxHC3DuavaTuXOuOM5TGfNQ1bXD7wG0Ao6TVlNLS3AKl0urVxcY9dSpTL6Q7ZspkryzGgpJ4gHkWDtr0ZBEB/5Ef+JtAa8mQt67oM1G6Ti20FVu1IuVzabI1ZBeB2ITWNkpH3Ur6qpnEzykQ3UJAHuZBkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751433; c=relaxed/simple;
	bh=cYaR6ewOWivZZlu2DDOh0DduYyQR/eNhIL9vDyNReew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLLU2pg7s3RK8PitLEjBI6uqY6KIe2jq9PtM0I5+pBMHbt0CzYurxjIh+N4vl2m1d42s2uOgqhvxawZaDE3wwdSK5KlKMQtpTo7YCuTIRqOY6zOPEq2SQfsHz9Nig3GvlvoV2B/NN/w0l1/LPJ3SRUua/NpXu7SJYsb1UPHyrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3ajAkcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE9DC433C7;
	Mon, 12 Feb 2024 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707751433;
	bh=cYaR6ewOWivZZlu2DDOh0DduYyQR/eNhIL9vDyNReew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3ajAkcW8V+khACIZ14JHJM9bYHDzSX1C26WVvQZx6z5ieTGCXrzXY7a4GcAXIv+1
	 Ijl5F4vGhkhQsUwd5bmJxeDUYySST0LmAo2molV/d57vXkAoqM9slOkcoOoNXojjPl
	 rCLc1xQfN6NskdsrC9EGTUZy6MXJLyTr0qUeejv/tTwT4GrDABzagmnIwq0AAwUHbQ
	 YgOjegQ6RuaixSJcWz6JcFtWOb3CGPl4scPsXXdGOThvFBnGcVAmeJuICpyr7KyUiL
	 qjk1YyEODxAcG9O4qQe14njzvfqSWj4zDC27EHoAJPTOXemgAH6QzGjC79INyLMnzq
	 Q/+pfp8Rfuz2A==
Date: Mon, 12 Feb 2024 16:23:48 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hrtimer: select housekeeping CPU during migration
Message-ID: <Zco4BKuwYYI3NRIA@localhost.localdomain>
References: <20240211135213.2518068-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240211135213.2518068-1-costa.shul@redhat.com>

Le Sun, Feb 11, 2024 at 03:52:13PM +0200, Costa Shulyupin a écrit :
> because during CPU deactivation a timer can migrate
> to isolated CPU and break CPU isolation.
> 
> For reference see function get_nohz_timer_target,
> which selects CPU for new timers from housekeeping_cpumask(HK_TYPE_TIMER)
> 
> Inspired by Waiman Long <longman@redhat.com>
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

