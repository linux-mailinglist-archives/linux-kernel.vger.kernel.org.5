Return-Path: <linux-kernel+bounces-117330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE0A88AA13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5066B1C2CC1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F5140E25;
	Mon, 25 Mar 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="T02H3tnj"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2C3DABE9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379303; cv=none; b=UoDc16/v+8zRhOpy7fR33yDVCvaBjKjgewyH+YIuRBfi6/UC/xrQqNgPpvOy6hqNz/VPlhnhbZ8VMDi0acdXja72BGi86N7wubhdO/4RxO6I8wvaUH5Lkn5c4GvTpn0RRg5sRg9exI66gdUQG6W3/bN8wsE32ilfD+C+YmrEuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379303; c=relaxed/simple;
	bh=fYekI51MqTGBNdRqzrAp4Nb1sLztp60fGzNOTQ8ncS8=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=TbRHV/7dz9WNedkzoh9+/uaiOCvdCd9lKDDG0dqtAu55fFqJ5YNu4T7gPQ3qNkktVrnBpLUehH1MXp0g/3SzSty/wMYPC//MBoIjTDT1qzWWWRBdXCOtooL2Dxd+7XGZAsM0nte34iet2a5WLXANnBUCW6oxGj1UvFSmV5c5R9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=T02H3tnj; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711379295; x=1711638495;
	bh=fYekI51MqTGBNdRqzrAp4Nb1sLztp60fGzNOTQ8ncS8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T02H3tnjVxQB3UA59iZBkru3PY+aEdDxxncsg788qVjGlksWUtUOtPG+1WHFX1O1S
	 nheWDkVKf4vn3hEubyhZOjVCfDyfVZ6N21/UgimpS37U+OxJerecfXdqtyuyiWrSPi
	 cLQStnZLK25wSgScK12/cuxrXuwh5ZmXxNGIHgldxqj2LP+52LtX0PQCrA58kGUvC2
	 5rMakqskzrmoPk8zWGew8XW/YBG/HCEHZbRVb/roFIcFolufU1WQyNzK4FEhns3z3n
	 7tbNjhSVa0h6SkixEpx7JB3kMl1WRUgquWn6YTp5M+DfSCxb9Ytjscolx4t+/PA6/3
	 0T3ceazIpWK4g==
Date: Mon, 25 Mar 2024 15:08:09 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: A <akira.2020@protonmail.com>
Subject: kernel 6.9-rc1 fails to compile if debugfs is disabled
Message-ID: <90Yi8Mi97ZeyRKpA5Yq9JkCtpOyEzgd9Qlbx2wwZwnO-C6dMiRZs6H3SV2vCAeDhFYl4ZZzSlG8jbu0RY_2jRp0Ka5oh9RqruW-6Nyypr98=@protonmail.com>
Feedback-ID: 7267082:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

https://bugzilla.kernel.org/show_bug.cgi?id=3D218640

Bug 218640 - kernel 6.9-rc1 fails to compile if debugfs is disabled=20

kernel 6.9-rc1 fails to compile if debugfs is disabled (CONFIG_DEBUG_FS):

it fails here:

```ERROR: modpost: "ras_get_debugfs_root" [drivers/ras/amd/fmpm.ko] undefin=
ed!
make[5]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[4]: *** [Makefile:1871: modpost] Error 2
make[3]: *** [debian/rules:74: build-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess returned e=
xit status 2
make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
make[1]: *** [/ram/linux-6.9-rc1/Makefile:1541: bindeb-pkg] Error 2
make: *** [Makefile:240: __sub-make] Error 2```

if i enable debugfs, it compiles without failing.

