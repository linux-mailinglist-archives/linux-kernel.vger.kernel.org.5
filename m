Return-Path: <linux-kernel+bounces-136964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C1C89DA63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CAA1C22DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBFE130A5B;
	Tue,  9 Apr 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xKkGsbU4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CB7FBD3;
	Tue,  9 Apr 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669571; cv=none; b=mJ883A1doDz4FmgO1WTRtTMwE3A3w44gb/VRvcCJPyJ+P+ROSQFbKIgnZE2qsXULkqEwAXNeurV/PxLTjjCVy45vRqawLmuszWBghP3PMUJbsar7ta4hh16xgH/wM4q53jYz/SqaeYL46nYvTFNnUb/59tazddH7ybuGAmL6mOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669571; c=relaxed/simple;
	bh=RiIwGLCd0WmHcv9dwUh7ZyBlB74tyvzcwHjtFnzVHoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb3sBpqh1/R2t40gbQnDGfflTjzNJtJ8Tik6WaXmPRS4tul8Iz2yTPE1ekEnixefEzCLBONVz7MwpFsJL7WYpQTN/n4EQF05StnuiAQtrBjQpY+NF/JNBCRscy2PW0CIe6Gyuz1xcxCbPhxw6e0N5zw87tqJQNFIRlRtOenLdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xKkGsbU4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tEIbor9pEQA30BeptpyPyxQfeq6lHOGOFBBdte10kwc=; b=xKkGsbU4yDo8cQiMtUTZFLfVV6
	EW1omNWvMb2sqkmhkizSWTq8vqEdToNCE5w2vIYW8cS5nXnm9oMx6dCTElFXWKGQFX5Z/Vcyhg3wB
	/OBCRuVg3bplmpxTN6qRTJqTVIKD575IWhWsYooFihI9r4OHKSMrCe2u2tlYc15jhXJDy8mtJVFqD
	cdBkrkOk9F67cSdr46++B4aVEq6YPdNkgTBxZKKtKpc5V3xVpwQBMOz0P4aUb8/qYtsfR7yHMn0lT
	rwv0X0L3PPhKw5mGSkHQhaLUtDVeI8asmrM1/99gk6iYF7hSrnEJeZuaumcZSGlbeYXCbDOpLO9ST
	M485Stbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruBaj-000000028qr-3OZQ;
	Tue, 09 Apr 2024 13:32:49 +0000
Date: Tue, 9 Apr 2024 06:32:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xfs: xattr: replace strncpy and check for truncation
Message-ID: <ZhVDgbRoF9X7JSdt@infradead.org>
References: <20240405-strncpy-xattr-split2-v1-1-90ab18232407@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-strncpy-xattr-split2-v1-1-90ab18232407@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 05, 2024 at 07:45:08PM +0000, Justin Stitt wrote:
> -	memcpy(offset, prefix, prefix_len);
> -	offset += prefix_len;
> -	strncpy(offset, (char *)name, namelen);			/* real name */
> -	offset += namelen;
> -	*offset = '\0';
> +
> +	combined_len = prefix_len + namelen;
> +
> +	/* plus one byte for \0 */
> +	actual_len = scnprintf(offset, combined_len + 1, "%s%s", prefix, name);
> +
> +	if (actual_len < combined_len)

Shouldn't this be a != ?

That being said I think this is actually wrong - the attr names are
not NULL-terminated on disk, which is why we have the explicit
zero terminataion above.

How was this tested?


