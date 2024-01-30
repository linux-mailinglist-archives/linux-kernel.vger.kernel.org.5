Return-Path: <linux-kernel+bounces-45027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B5C842AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A5E2879CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6AD26AC6;
	Tue, 30 Jan 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4Vual+R"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B3129A60
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634952; cv=none; b=AN5gxta883ENNOykS7TU62pZhW+cyVGJB0S+jU6SrECM2XCo3lGfj7e1W76IXHtg9/EtJbe8c6u+4xy3APO5jYvCXsSAAk5z85qLkbzlCZvunrtqmbGWKpYnkdrHOFPIMUOAuOEW8DTMO4yIsrqyakap0fxUzkTFjmzP7hCHKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634952; c=relaxed/simple;
	bh=a4gF2BSCa8pQzxQFzlE7W++56NTSR9zIITRYJM2ECyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QRi83wAGEEbsWgOoO6Vga3hxIuierf7UUlzMiCI8jKsIwri+1jTaDbQDrDYfY+ihdg7dz2FKsi5DEy54CufQhMmJeO/3CG3omFuEKA90K40uLPjN0wHqKsVMGivSpPrI1oc1SIvv8UbGYNqjghfRd4Y7zqVLHC/xy7M3ARNWtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4Vual+R; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602abe779b6so74711017b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706634950; x=1707239750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljX+DuGhu1oX6Z5GCA189BtLMB06zqPcIW20thBcqTo=;
        b=X4Vual+RUWGWgBzeomIisszcFIQy4l+jlGLLTU3D7J7QQ8oqHMmaThNpcnoMN14Y70
         ebWVGvR+ewnVuqcvXgvf82zQhnZTlTyOnOrBK4nvcyFGGitMlS3NVpIcizAklHR7IzAZ
         dX5lpZJJG9XLG9tV20xdxnlVVorSlm6d4M71W/Q1fJK4fiePVkSmejBMCzAKlVj22df5
         rbx/dt7NW3or99vyJmTtuBFFByJL5EBNesKQLVAr3wTVsIbTFmcU4uOA+/7HdK3cwDIg
         YAmRJrfLuOchnnOnweh0LhslXCehQOSz4FikWmiTyhmEmEk5zY+ExFL0GY0bkp1l5DTw
         6/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706634950; x=1707239750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljX+DuGhu1oX6Z5GCA189BtLMB06zqPcIW20thBcqTo=;
        b=Rpdm4aylk3KxQcyZkWA7sQbLi8FqkfgSl05dyKROifsWdrp6aO4vbfXutLu4c5syWu
         L15Ftpam2clmDN2fr9mKVLcYqgGmjaccacFTRoYNbTOn3FyEKJxwpJzRqj6Ow9aHlATX
         z8lo7nlpaSDPtJwq/8gi8YhCXlj0h7du7nnSlt5R+rha5OWsxQN5rCGXu7H5ppMpU38L
         ccDoaeNms6t390RLcC4fsXdacVLT5vuHtfF8lgdrwxUiZhfVGqOuMuoQ+FHA3gFzrpX0
         5+f6OPubf0+MOjb+6+4xXiLptatJ45yiPQx7lyEHS6CuJrsB9B8XiaplgazlUzYVDTM3
         aDbA==
X-Gm-Message-State: AOJu0YxYC7oDTVslXsx6EiDp1LOc+CkhBOPutJpO9itTTkSbnbYAsgcM
	bsNF60qo8MUkjy7+To7IZtsfCb0oMt0ZOiHrEhs1r4rbfW3eQP6IVC3eiHBfF95k9UZZcezJE8u
	ZJCRK02iJco6g03EUwg==
X-Google-Smtp-Source: AGHT+IGFWkMUxyhX+tCuHFDlz775XADs3S2PtN0E3PqqbVP7wLG0M0EORo8t9IHM7cv1qMgSfyyRcBQufD0n1spe
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:9a42:0:b0:604:594:2a58 with SMTP id
 r63-20020a819a42000000b0060405942a58mr48745ywg.2.1706634950186; Tue, 30 Jan
 2024 09:15:50 -0800 (PST)
Date: Tue, 30 Jan 2024 17:15:48 +0000
In-Reply-To: <20240130154632.GB772725@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <ZbiwW5BJhFeGc2Bd@google.com>
 <20240130154632.GB772725@cmpxchg.org>
Message-ID: <ZbkuxJpoHrUF-ULa@google.com>
Subject: Re: [PATCH 00/20] mm: zswap: cleanups
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 30, 2024 at 10:46:32AM -0500, Johannes Weiner wrote:
> On Tue, Jan 30, 2024 at 08:16:27AM +0000, Yosry Ahmed wrote:
> > Hey Johannes,
> > 
> > On Mon, Jan 29, 2024 at 08:36:36PM -0500, Johannes Weiner wrote:
> > > Cleanups and maintenance items that accumulated while reviewing zswap
> > > patches. Based on akpm/mm-unstable + the UAF fix I sent just now.
> > 
> > Patches 1 to 9 LGTM, thanks for the great cleanups!
> > 
> > I am less excited about patches 10 to 20 though. Don't get me wrong, I
> > am all of logically ordering the code. However, it feels like in this
> > case, we will introduce unnecessary layers in the git history in a lot
> > of places where I find myself checking the history regularly.
> > Personally, I tend to jump around the file using vim search or using a
> > cscope extension to find references/definitions, so I don't feel a need
> > for such reordering.
> 
> I agree that sweeping non-functional changes can be somewhat
> painful. However, moves are among the easiest of those because the
> code itself doesn't change. git log is not really affected, git blame
> <ref-just-before-move> mm/zswap.c works as well.

IIUC with git blame -L <lines> <ref-just-before-move> won't really work
because the lines will have changed significantly. In the future, going
through several layers of git blame will be less convenient because the
function moving will invalidate the lines.

> Backports are easy to
> adjust and verify - mostly, patch will just warn about line offsets.

I usually use git cherry-pick, and it sometimes gets confused if things
are moved far enough IIRC.

> 
> What motivated this was figuring out the writeback/swapoff race. I
> also use search and multiple buffers in my editor, but keeping track
> of the dependencies between shrink_memcg_cb, zswap_writeback_entry and
> third places like load and invalidate became quite unwieldy. There is
> also the search in the logical direction not finding things, or mostly
> unrelated stuff. It's just less error prone to read existing code and
> write new code if related layers are grouped together and the order is
> logical, despite having those tools.
> 
> The problem will also only get worse if there are no natural anchor
> points for new code, and the layering isn't clear. The new shrinker
> code is a case in point. We missed the opportunity in the memcg
> codebase, and I've regretted it for years. It just resulted in more
> fragile, less readable and debuggable code. The zswap code has been
> stagnant in the last few years, and there are relatively few commits
> behind us (git log --pretty=format:"%as %h %s" mm/zswap.c). I figure
> now is a good chance, before the more major changes we have planned.

I agree that if we want to do it, it's much better now than later, just
presenting a differet perspective. No strong feelings.

