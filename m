Return-Path: <linux-kernel+bounces-44819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321708427D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E881F22B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997EC82D7E;
	Tue, 30 Jan 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XFA5OF+9"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7421105
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627966; cv=none; b=lehDuiiC0EEH7uFleQFwMqXbuCH6PJ/si76uKVqQphS//ZH1go7z1Ona4Rdyb8qPDy++N8hGBeZBZAKsg291DMtWwvlS9qbjRc1Ash05s0B7Es77FRjdn/N63c5W/A6GFobjJUk0b6sRjKGiXr8T7bbJYgUx7o0qRhjL8KVLXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627966; c=relaxed/simple;
	bh=LMAcdJG3xZ4+Ru0fXLgdqDWcwD0srNKy2FBjYjgi3MI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DI/WtU/pN3p6SCT6pmtT/2Q/zeiNgvHUaSDIS2Y1hY8txYJf6RsQF63lrgdyyr+i3fTg+MGNOiKBbw4jgVpGblKHX7gwayz5BhX7EHLEmKIY9Yc199fpI11oXv2/Ic36Y8MzIwSZVYfnMnuCIvsf4MMIQWlQbVQpylA7Az8bBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XFA5OF+9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LMAcdJG3xZ4+Ru0fXLgdqDWcwD0srNKy2FBjYjgi3MI=;
	t=1706627963; x=1707837563; b=XFA5OF+9I7LOmmiXjMRn6vPHXEAyPn+KoIa//0Z/JfYofwu
	gJVo3DWclDIr+4OxdBCngOlIMHV03LbXmUXP6MPk/iSnmAxLa19HEPYc+ug6Yi6NmfVXiGmxt9xI5
	CUZPK77rLJCddTHjETf8qq7PGCXZMUJugKgUVXrwMDUgG+X1MmqttDb2bcKUfcIr+0QPiGSO0VPtd
	4ZY0yZMRVICyavbiFlj1qNxrDHKCT5HxH9phvPgm3jIHc74s5pXJTwtor1KvAn3wmnu21NoPOtaZn
	mCtL1jn9UQP8bmfWIB2TnBdNuFFwJiyCkB7Prw3T7MnlA6B5XBaMcACQYj5x3Gfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUptP-000000067XL-2uX8;
	Tue, 30 Jan 2024 16:19:19 +0100
Message-ID: <8681168464fa85061db4a7234f89cead65cb0261.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
From: Johannes Berg <johannes@sipsolutions.net>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-kernel@vger.kernel.org, Jose Souza <jose.souza@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J . Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jan 2024 16:19:18 +0100
In-Reply-To: <ZbkSvcEtRgTXuzgJ@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
	 <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
	 <ZbgYyra1Ypa0nf6u@intel.com>
	 <33df6c78c4c47a8f57a1c2bfe835065becb5a253.camel@sipsolutions.net>
	 <ZbkSvcEtRgTXuzgJ@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 10:16 -0500, Rodrigo Vivi wrote:
> >=20
> > But I'd rather not, it
> > feels weird to have a need for it.
>=20
> We could change or CI and instruct our devs to always write
> something to 'data' to ensure that devcoredump is deleted
> before we can reload our module. Maybe that's the right
> approach indeed, although I would really prefer to have
> a direct way.

That's not really what I meant :-) I think we can agree that it's wrong
for the kernel to be _able_ to run into some kind of use-after-free if
userspace isn't doing the right thing here!

What I meant though is: it's weird for 'data' to actually depend on the
struct device being still around, no? Whatever you want 'data' to be,
couldn't you arrange it so that it's valid as long as the module isn't
removed, so that the 'data' pointer literally encapsulates the needed
data, doesn't depend on anything else, and the method you pass is more
like a 'format' method.

johannes

