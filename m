Return-Path: <linux-kernel+bounces-135324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A368289BF03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441E91F2469E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5971F6A8C1;
	Mon,  8 Apr 2024 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laHvL6KL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C162AF13
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579636; cv=none; b=nYzmT/7Fdi+loQQMClJj4p4dTHnKWw6Qdh2qjYwSwWRHHjiRK1JEBSuVcKVc0AdV8biL6rKMBPM3KHFtq0IrtxW5i4dJWGe/Bj50qE/srWYH5HMtQ4moHLbnSSEw/wHiVFZo00LpOyHkW5Pp2rC2HCSHHhJIWjFJxPNh7AtEt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579636; c=relaxed/simple;
	bh=CQ0ErHvsB0mNlDd9JRTK46QfVpf552+gHGufwSuzsQE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FHyLijYYuDyuOwVh6EjcBpZt5y6wWfYL7XbnAsIHkURtF87P+yAEuHqqCYywmmUsMqlUhBRB7oZ7dtdHCPoODyiqyzABnu0Hc0ELwbr9PhNL/B9bZCeuGqtCwpMVQeLCMqUdBtRvcPfjXs6z45ejo4oqeKte2h3d1qLzfIWZjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laHvL6KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C44C433F1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712579636;
	bh=CQ0ErHvsB0mNlDd9JRTK46QfVpf552+gHGufwSuzsQE=;
	h=From:Date:Subject:To:Cc:From;
	b=laHvL6KLWYGH6nyyQVLW5RVgF2KgJrXs4R+cby4tjKACU4fYVZrBkC5qFqbHk+nPR
	 Z6j5+AgQly6mGDqG+ie+2GMlbGDUo2am1Ny/m/KN/Rh571JBYGjJoaV7oDrVS5EWeL
	 VvO8H3nV4qt+tgUt6SRrxQKMUu1m2DsfNzgaxnfTYCWQogxItCpTSPdDM/EesaMWRE
	 i36fw7+1OPvEcDgkrnwEgrv5noDsBMZ2UYcA+FHbta9Heq/mp7KoG4RJKojmmI2EgF
	 EJFRXp+zeAt3eca87JcBo+TWVnVIFjund1Qko6g3CSsnEry0IMdED57j3/fUYcxCYp
	 54aTF7Q06CFeg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516a01c8490so4573288e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:33:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyv0tJA8Bjak5KRuXHEL33ASNFGbEWZrQR4JwlaUxP5GEyYsiuk
	mE8DeKxQ83Jjrnu/EmdT0tvgrS8fxjqmxC3TRjYh2bdHvCxgtGOvCzytCcv583SlMTWYdpqW6E2
	NT16s8MlaL/VmIBkZqw0iyKiofZ8=
X-Google-Smtp-Source: AGHT+IFkJt/bCJB0B8469W93xsexFMnmcglmjWAa7rMn0KsXFSHLex8VLunR+xIlEVwB5fQyn7tua3Wt3qaazDiwDvk=
X-Received: by 2002:ac2:42d7:0:b0:513:dfac:b29e with SMTP id
 n23-20020ac242d7000000b00513dfacb29emr3178850lfl.26.1712579634907; Mon, 08
 Apr 2024 05:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 8 Apr 2024 21:33:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR576NEto9ewk+OhGBfh6+xicB3KL-41gUkc5g_68UvJw@mail.gmail.com>
Message-ID: <CAK7LNAR576NEto9ewk+OhGBfh6+xicB3KL-41gUkc5g_68UvJw@mail.gmail.com>
Subject: Question about context imbalance warning in sparse
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Luc,


Sparse does not seem to consider the first parameter
of __context__().

Sparse does not warn anything about this code.


void foo(void)
{
        __context__(a, 1);
        __context__(b, -1);
}




In Linux, I think sparse should warn
the following code
(lock and unlock different locks)


void foo(void)
{
        write_lock(&my_lock1);
        write_unlock(&my_lock2);
}



-- 
Best Regards
Masahiro Yamada

