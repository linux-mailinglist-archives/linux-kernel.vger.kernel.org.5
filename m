Return-Path: <linux-kernel+bounces-123484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9ED890950
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590E71C28C04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03821384A1;
	Thu, 28 Mar 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PHcNGxwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64B137C4D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654570; cv=none; b=g1j9+LTy2p439hlX+aT774BBhAJUzdHG2npbBdCPEpx3mUGQDe7MEJcEuGeFL8oqWVepMxQdqYSuh2CFImKva59/KmrA4vqsyE0IXN/PtKPvbHlxjCGcv0y0boU3kSgnN3ppAdGPuZaFMR1AoK0FJ0niNb1Rh7GdRVU/ho3BZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654570; c=relaxed/simple;
	bh=LeT5xJzgVsEttbRtHWNAa/8vqU+I5zEfspgibVh5G+U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZGn7pD1Gt6PKm6+sWnNYiZZwXplJNoL4nMX9BKlNwFKZsN89EuovKlYvfNtBJ0dQhWksZpd4oQA4qC3YdxGRhZ/gHSW9AIy6wBAxF+eRfDMcQLSDhdT3EpDya5O8zXXswav/Uno+wS0wDOMZJNY58ZVqKDvEpbBm5cbrCirQQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PHcNGxwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65FBC433C7;
	Thu, 28 Mar 2024 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711654568;
	bh=LeT5xJzgVsEttbRtHWNAa/8vqU+I5zEfspgibVh5G+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PHcNGxwx0bideR0J9s+r1ppJyoVlRk+cPMJ048+M5G2sOPhehYOa9II9ErMGGteHu
	 xzFdCXHVvhS6uUub8L5IuDRUogFWTarp3XLDJ7DaJ+u/UnwbwPVOjV0gEBSxx50F3N
	 pbxJFiU+LdqzMH27WMT829LsSZZyjj0xfGJq22oI=
Date: Thu, 28 Mar 2024 12:36:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: Introduce rb_remove()
Message-Id: <20240328123608.a20ba1260aa9467df9f4256d@linux-foundation.org>
In-Reply-To: <20240328064539.95795-1-richard120310@gmail.com>
References: <20240328064539.95795-1-richard120310@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 14:45:39 +0800 I Hsin Cheng <richard120310@gmail.com> wrote:

> Implement the function "rb_remove()", which can perform the removal of a
> certain key from the tree. Once the node with the searched key is found,
> we call "rb_erase()" to perform the removal of the node, otherwise the
> key doesn't exists in the tree then we return NULL.
> 
> ...
>

We wouldn't merge a change like this unless there are callers of the
new function.  Please tell us everything about that.


