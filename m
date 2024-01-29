Return-Path: <linux-kernel+bounces-43452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCDF841407
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3201F26BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794476043;
	Mon, 29 Jan 2024 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xaSmdo7s"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B766F08E;
	Mon, 29 Jan 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558993; cv=none; b=GvcpCoSJeT5brlBx0kRoPLA8I/LxgdoAb0FVUxPwbZVglO6jtH2EGIy6hItPxUkvAs/eLCpCxyF0TKTB4AE66yYIsFG/Xoxbn+9rBT+y9dpvsOj+0klgEVh6RcsvjsRH16pfIQKwDk0KRs5nyDcJppR3ZdYez3fS76HHa7jPNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558993; c=relaxed/simple;
	bh=hOVjeSiNeXA8QVPW59DbtV3sJGuJPnpNfEpKdUb3GXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUFAgLmQfoBMN5b1sclnAStFJLrKW8Jw4ZrH0QAR2NXeGI80/SNdn4ZM6LACW74OCRtg3MFLqC8NbAtegRa3bA7oL2B0BTXcIuS1cqjx0tEqH7yn8siqA+qslkamIVaoEIv88VXx4t9yWdjybfLfzI7rsqz50iX+Y4gv3R+hgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xaSmdo7s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CjXxVViu2m/Opq46i9BO5RAH1W1zGxIwhMJxClwKauE=; b=xaSmdo7sn5dI7eoYOssTyzogFC
	7pSfzcF0ewY6UsxvkTDmRGlB8Wa4EKlIt2tHWkAmVX5iqyMxRq9LcngsFMzs6UW3c78SeF9JA6pfA
	ehP3VRDE900eY25bMV15hnBIk4zsnfB4mBLOXErjXw8VZR/BwqLnGE3X2l2KJ8CnHjFV9POxNKl96
	AKa86I3MkrKav9nOU4eRwtJr4ESDM9Cg/qQ7xAOAvTTMJ4p2VJcq6P9IyiXrJaiFZyzjC8DSkVSJr
	80EdeREb6GSoWO4JZpWcu3cb+g5JkF6se4h+MN48sQoOTn0yu/u+oMLKk7D4yA5VGtXxuRwhfBioo
	cNzpNxYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXx0-0000000ED41-1o6Y;
	Mon, 29 Jan 2024 20:09:50 +0000
Date: Mon, 29 Jan 2024 12:09:50 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/3] init: Declare rodata_enabled and mark_rodata_ro() at
 all time
Message-ID: <ZbgGDlgrLhB8tcGI@bombadil.infradead.org>
References: <7b5df1782e94a755b4a18733af44d17d8dd8b37b.1703149011.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b5df1782e94a755b4a18733af44d17d8dd8b37b.1703149011.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Dec 21, 2023 at 10:02:46AM +0100, Christophe Leroy wrote:
> Declaring rodata_enabled and mark_rodata_ro() at all time
> helps removing related #ifdefery in C files.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Very nice cleanup, thanks!, applied and pushed

  Luis

