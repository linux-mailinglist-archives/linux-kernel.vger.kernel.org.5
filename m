Return-Path: <linux-kernel+bounces-127468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469E4894C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019E0284164
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544C374C2;
	Tue,  2 Apr 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4lA6HgX"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC5175BC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041494; cv=none; b=O58VhP2SlM8Gyr/xnIJs7R+2dWxL8wLHtypF1/2pNzxPdcIiA1oc75Ck/cu/68bmOWjdAw9EPw7eWkNCug6RdiaA6TWdWtRR0BQ0vdcA5hxI9uF4jQbYc21hJ1lsEQSHdBfrGXhVOUTzS7SV0htFnBOCEpG/e2xwrzVgb4UJ8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041494; c=relaxed/simple;
	bh=IPQbo+kDUd7xbiYKUftvSuYMx6VaFrLZDhUMPLmP0Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSKH8XULXD9RjvTzQ/nmS4WEhcIsBnG+rgswbucRryxL7Vf4n+z8YuwqzXQs7ek8S5a4KFGWkvZATuRlKnaOflaKBQc4UAzXkhxB3gQDmMqjfesF6vbPtmTbrOlnS+4v2+t8KZmnAVzHdXPAxNYhg3K3NMWeYI9QW7VQz42xBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4lA6HgX; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e89c87a72eso1295205a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712041492; x=1712646292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPQbo+kDUd7xbiYKUftvSuYMx6VaFrLZDhUMPLmP0Sc=;
        b=A4lA6HgX3Dq7RkAXx0fPifsYTyKCAC38/34Rrgj7Jphi1eWMAVdieAatMgc7/6B7aK
         9SkzMzUydtfDN+N6KCLslwCje7HnXc0kfCETFlFk0MdVkn7ozSlVPrkpCGtdxxpzh5d3
         HusXCZWl+8dfyjhNmyfn7McVO2O5pI8IDNw2zRLk1dkVuCN1Zpef6vAnIypzsYKSg154
         qr9z6IFxNvxxQGYKshnW9I2V/Dy9r3ItFyf4+j9cPNmJDqJYjVE+oM7YbeYArQ1MJ9Be
         u6XDMj6a6AdeIbykxSmaA3MvnqT4WeSwPr5n1mVHzvsZD4Je/ce/De02i3Jp3Hoa36LG
         xu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712041492; x=1712646292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPQbo+kDUd7xbiYKUftvSuYMx6VaFrLZDhUMPLmP0Sc=;
        b=jMpFoD+NWLSKVf7vvqjb8/5oNurQhs0PDytWxIFvsnRnUMl0VaY6AO/dun+U9Kxmww
         ize7VhWEy976MZkOCtZsgAPAhvjr3D34vPhVGwOhABtO+W63jYqxIXwWvB9CSzcw4dDf
         4/UsDiYnPNIjZv/A54SA0AMezaKiPmBOXNGkqrGwjVpimfNyZBBEAhzLqg60ehJ5DO5T
         wiNYvsFqzdiIKnaF0EamdcCLfCOD5kN/BfwXJ3xCbLsAItlSRdqPZU2R0Jv9N4j6zPKw
         z1ZZiYpw0Kq9odrgcs9aJugyAz8WrfeimcF9oj8RPlU+WmLtogGv9OYeNAKF7NSQDJ4y
         1N2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1FrI1by6B/LmpDWrasMF6UE0EktWdm6Ln7ne+Ws2wEq+0jE+Ri+tx5MUz6pr+Iz/LVp2Uyh9fXG5YiPX44XeZas5o8nP/nrXvitEm
X-Gm-Message-State: AOJu0YwB5PqCO4k7poPz35nEHTVt9Dj95A3vl936ilY6WUCGNG0qrC4X
	/ilCJUuLjz6bQtOgNS/ViwlpyG/8G/u4VoSLxGGvVkedCsRZEC1NqlAtT2uGJt2eTZrE50AC52R
	PBc1ar/NLnkbSFEbsb0oVLNs0TIXhHvY/xzYa
X-Google-Smtp-Source: AGHT+IGhF/OHGGLMOXdiFHrcqBKBvthhiZItBAVgZ8l5E6BDcDM15/znNEvCA6KvzPFRohHecG0ggecYLBssiggM8EA=
X-Received: by 2002:a9d:61cd:0:b0:6e6:a9e2:8bc6 with SMTP id
 h13-20020a9d61cd000000b006e6a9e28bc6mr11525473otk.0.1712041491990; Tue, 02
 Apr 2024 00:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402001500.53533-1-pcc@google.com> <b939165e-a227-4b96-bdc8-12afba801c03@suse.cz>
In-Reply-To: <b939165e-a227-4b96-bdc8-12afba801c03@suse.cz>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 2 Apr 2024 09:04:09 +0200
Message-ID: <CAG_fn=XL7tSuCuBXKf1YDiETkFMte7JyLrSE+saDthtJj==hUQ@mail.gmail.com>
Subject: Re: [PATCH] stackdepot: Rename pool_index to pool_index_plus_1
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Peter Collingbourne <pcc@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 8:54=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 4/2/24 2:14 AM, Peter Collingbourne wrote:
> > Commit 3ee34eabac2a ("lib/stackdepot: fix first entry having a
> > 0-handle") changed the meaning of the pool_index field to mean "the
> > pool index plus 1". This made the code accessing this field less
> > self-documenting, as well as causing debuggers such as drgn to not
> > be able to easily remain compatible with both old and new kernels,
> > because they typically do that by testing for presence of the new
> > field. Because stackdepot is a debugging tool, we should make sure
> > that it is debugger friendly. Therefore, give the field a different
> > name to improve readability as well as enabling debugger backwards
> > compatibility.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/Ib3e70c36c1d230dd0a118dc=
22649b33e768b9f88
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Alexander Potapenko <glider@google.com>

