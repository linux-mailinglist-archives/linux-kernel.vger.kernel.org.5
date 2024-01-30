Return-Path: <linux-kernel+bounces-44099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89BD841D47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B501F23574
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F30C57302;
	Tue, 30 Jan 2024 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNAAiCYG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532856B7E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602360; cv=none; b=VaPX6aTB0C5nXHO7mkmpLGi7kEfqe34byh6LbFn7E+2dB6Qa3CZiWUkP6HXbmg3/GzmHCLeRJwos8UuzxdCaGWrX9UWPJwUM506u3MoYIVTnSoK+w5V7TWwxif82hTU/I9pjxRzQ6aQ3CvcEsfewdWxbEw5um8YetKVDAIYYeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602360; c=relaxed/simple;
	bh=+9KixsXhJbFgsR1R6Jk8tcgYUTRD+kHFPGe9rg9KqZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSfs/oMpx/5n8eOh1X5AdZP5KgnRk2Y/b4mJI7YdVbi/HTbvYrVk95wnqx8baErNmGXxmADgCBYTuIg2mNs8W2AomMa9oO/lp7180QgMruUZn3ncf+GEZBfRiRRhkQLfkCadYcPhlsbHIf9eU87e4DYupzy4A/quCvIT1CMLMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNAAiCYG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc2470bc0bdso6325657276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706602358; x=1707207158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIFgjiuxwRuK6BHQq+omF6J4YBG6WwTGzt+ObEmxSXA=;
        b=CNAAiCYGyXAG42esBUZ2peu4tHKWaMmOA3/rIcuREKNpXnlPJZUYfivmA1tkAir0wP
         98guc66GVBGEBWoNgT1gKiUseiyVPfyOk897p+1rkVl42UqfZduHQp+JMBkq8TBRkRFO
         1k+gKpBoI1TyYykj68sW2cJIXuIcdRFtL+6u3uSVHP4xil3OB1IqWicOysUxqbLMnAAd
         2rPrhWGkgScN6sEvPhZLPmxuvYm5e7O1amPBh+rwmNUS30Epgt4DeMwYqnFZRZ1OLA7b
         avNg4bc788X8tWpE3CF72sfW5durEFdrV3uc/+dBW2uclzyDSVAtAVM9W7Uw+FWmBOOa
         40SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602358; x=1707207158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIFgjiuxwRuK6BHQq+omF6J4YBG6WwTGzt+ObEmxSXA=;
        b=V/jE09gNzBjfBhrr8e+Y4Q6GlgNchw71nSLHTv7HqIdmwkV6ea63BRaT2TajbNl1y4
         QYI15oT2wpSkMj9Ox+gP7Xb56Y2LxD8k39lLbktXKWfKLTbN/wUHepuKbSrR+nGNHK7G
         yiB9/hMxvWfMqKHY5+VgqVE9lFdHtyDSlO2zvoUGfM2A9Cio0/PfB5qmNvTFAECgwUQy
         hm6sucKBk7bdQzJHnOiGGPs8ntrtvYEt4NflU/jMhakdpIUwBaEAT+Q/mBOCcGGc28Qm
         irIQiqNJ24f3SRDQX4LcbaqHiUpGcGAPEkI5wgfQ7jdrfx2f9VBiYU+y93Qi2DQD0yK3
         axug==
X-Gm-Message-State: AOJu0Ywu716eguOpMBmeUunbMblCNT7cjjpsYvZr2PrykfltYGd967MO
	Gp2XKEySL3AFo7od9GgGVPvHvBxQR4ksVcJ9HRXO6E+Vzlf4tydIcHFjv7vgl6sh+DNLuAIYnwI
	ZhRS8TI83pOGrCVj/5Q==
X-Google-Smtp-Source: AGHT+IHvew4TiPu39aPMVPJ/xg1WbVfx9ZUC7tvmWTT6gWc2ZU8GFDvPJF34JVHQdfYQ1kuzlvjOeqk/piqEK/CT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2501:b0:dc2:57c9:b462 with
 SMTP id dt1-20020a056902250100b00dc257c9b462mr494232ybb.9.1706602358253; Tue,
 30 Jan 2024 00:12:38 -0800 (PST)
Date: Tue, 30 Jan 2024 08:12:36 +0000
In-Reply-To: <20240130014208.565554-10-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-10-hannes@cmpxchg.org>
Message-ID: <ZbivdLXQc_PgWa0c@google.com>
Subject: Re: [PATCH 09/20] mm: zswap: simplify zswap_invalidate()
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:36:45PM -0500, Johannes Weiner wrote:
> The branching is awkward and duplicates code. The comment about
> writeback is also misleading: yes, the entry might have been written
> back. Or it might have never been stored in zswap to begin with due to
> a rejection - zswap_invalidate() is called on all exiting swap entries.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

