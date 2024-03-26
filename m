Return-Path: <linux-kernel+bounces-119942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C951388CF40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581E7B264DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A99313F44C;
	Tue, 26 Mar 2024 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PqYh1sGs"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7313F429
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485376; cv=none; b=S7URs8+7RbtQt/Y5HgFZ6MX5yl4uh0+WLi4T6Jw5C1d1z3JrKIHZ4+EJZrxBUx/U5fsikMM3XnncCnU7PMhHKY8flqk6V9sy4T0hROX1NxiVStAVrjZjJ447HNGhJvTsiHpk4AJyceojnIgyNnNwQVeFijbf+4kXGQlDszB0Oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485376; c=relaxed/simple;
	bh=IMQPAjJ49lPvW6zxfZ7McTwU3P05cr/HzeW5oDoOwLU=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=FbWgFKfd5pon1Xv8udkb9pehUQTPecKsGj6qX1gWqUst35dzyK3cEh1sK5tB9y88ixWp6kAjWjI72vhoskZ1sqlkvXNKS+0P2k5enEB56pWnKNBNshlsUNZtGNtwp/sPJV9XB5uXRIuN9DImIZ9HCjnGP1+x16zWaE2gaaR3hrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PqYh1sGs; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69185f093f5so41385176d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711485374; x=1712090174; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QDvVmoc+Z0deH7JQ50OPy/sr+BDc5aYDtiEhzcQSmg8=;
        b=PqYh1sGscrdevCMakkxJ37hwdtdtuLbu/BWxlWZHjNaj+KFKKq7KVwsECngfroRoMq
         8/KBocQu1vYPYoYVXwFkR0SdPp8AScBIi85GcWxm8WTkTHo01b+fiHd8dE2Ubu7QzEQq
         Wi3KclJKtZOrnKC8TTPyVFNLxwYOKKB+cH/DxUw0dW1+RTdJCSxUTDBb2DKvQmZmueB5
         adRp1kFG2R7OTHSGRn4JniPhAh+YIIK8zz1Q2eaPuiQVqowsd2Z5NKtQTnboLwYm+Y9L
         iQ8Qeldc6Ml8FVBsi2AAOh1RvfDkkC8qhD9tYfu8xXU5MvoZzVOW9yauy0vT1YKXdfRU
         RZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485374; x=1712090174;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDvVmoc+Z0deH7JQ50OPy/sr+BDc5aYDtiEhzcQSmg8=;
        b=gtre0gJzqGKPDejpy6zWewl7Q4rK+gbTAaFuR6VzJZl3Xt0TzXobZFJufMBX/By2Nr
         lF/7Llpzzr/0exraiJyxF+d/L1ggtZwH83wTdY58LAvNzQndv4oOD5glJJJ/R9/tp+tZ
         qkzGGg37Bwq3ywvEQECPmvjUE25h7I4QEX56fOhoE9P7tl5Gbc88l3tMznqdzvdP6UC2
         QT+9xBRdQ6PzlDj30AbK4wvIKE/pOKm3KD0ramF79+J8QDXyICsRMt5H5qPEXgROSbAQ
         CN9QWutE2sRymO6jzzTkIUeqpXTqYBxo8E0YGwZdXij4KvZrvOENJldmzdvZThSIRllP
         4W+A==
X-Forwarded-Encrypted: i=1; AJvYcCVcgy/hI+RZOsUyBZEw4qJV73H339XyHQW6Fl1WRX0zyboRJ3I0AxD6CPjbY4eMp+Jr+6RZs/PkA8cnekvrig0uwS2JECZTeI3ls3cz
X-Gm-Message-State: AOJu0Ywe95Xf8QLiDd8vnto/iKp9mefPHBRNtxJO8F9LzM4O+xbcHdJU
	YLMprSlGgbdM9cVlSSfa6xw22DpWvlCQ3mvkIhoV9khihvSXhkzTvWWjWxzguw==
X-Google-Smtp-Source: AGHT+IEKHJRbcICslSOtPeGC8Oa9RrHc7xXPUnrwUavt2iIvT9Sxe5YWPrH9HTBjDV0o/UWvlg9q9Q==
X-Received: by 2002:a05:6214:2626:b0:696:19d7:49ae with SMTP id gv6-20020a056214262600b0069619d749aemr655883qvb.13.1711485373750;
        Tue, 26 Mar 2024 13:36:13 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q15-20020ad45caf000000b0069124066c2fsm5491304qvh.140.2024.03.26.13.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:36:12 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:36:12 -0400
Message-ID: <1852474c48afe6b3f3cd3960d80033fa@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: reject invalid ebitmaps
References: <20240315172859.634263-1-cgzones@googlemail.com>
In-Reply-To: <20240315172859.634263-1-cgzones@googlemail.com>

On Mar 15, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Reject ebitmaps with a node containing an empty map or with an incorrect
> highbit.  Both checks are already performed by userspace, the former
> since 2008 (patch 13cd4c896068 ("initial import from svn trunk revision
> 2950")), the latter since v2.7 in 2017 (patch 75b14a5de10a ("libsepol:
> ebitmap: reject loading bitmaps with incorrect high bit")).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>   update wording as suggested in [1]
> 
> [1]: https://lore.kernel.org/selinux/d476b21729cafb28c1b881113a563b1f.paul@paul-moore.com/
> ---
>  security/selinux/ss/ebitmap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Merged into selinux/dev, thanks.

--
paul-moore.com

