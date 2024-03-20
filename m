Return-Path: <linux-kernel+bounces-109185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462D8815E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92171F217FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1CE69DFE;
	Wed, 20 Mar 2024 16:47:21 +0000 (UTC)
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64C187F;
	Wed, 20 Mar 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953240; cv=none; b=n6rdhA6rApr1gHPOZErXqu/xOXmq8JXaMPm4emyvMG376w3I82JakTgNHeHlUbYd2CUFT/U0PSHEArk2zVqCMk43Ymj8AUGsMpWwYzltqeNRqaw1eBxfmM/qjgVMp4jh1Ku6rMrCGHJLnqdxnz3qlGuSc5gXqPuwwEzXTIRnymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953240; c=relaxed/simple;
	bh=KB4S6lfaY4jS9DUXhlshuPyIa2efuohtTmYPcJtq7Ew=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sPwo2cPnYNDSKFwNUoF3awNzsqU26V7RYGJkurI1laFuy7SDXD4TLj1z2HdrE8NG8pkG6pE5B++uaeYz/bMt+7fc0jj2265IC1Mr8ouF9u9t/F+74VN549rHrQtI7wPREJh/vAVlfTbwcsgUAhAwJGrgETJOcvgNpA9jfTEd690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jic23@jic23.retrosnub.co.uk>)
	id 1rmyt8-00BNeD-Pz; Wed, 20 Mar 2024 16:34:18 +0000
Date: Wed, 20 Mar 2024 16:33:02 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Julia Lawall <julia.lawall@inria.fr>,
 Dan Carpenter <dan.carpenter@linaro.org>
CC: Jakub Kicinski <kuba@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
User-Agent: K-9 Mail for Android
In-Reply-To: <f1bdbed9-8549-3787-bd17-ecd62851e8a@inria.fr>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain> <20240319124317.3c3f16cd@kernel.org> <facf5615-d7ac-4167-b23c-6bab7c123138@moroto.mountain> <f1bdbed9-8549-3787-bd17-ecd62851e8a@inria.fr>
Message-ID: <10F403F7-E8B7-48F0-90CF-3C8A8BEB10F2@jic23.retrosnub.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BlackCat-Spam-Score: 0



On 20 March 2024 07:32:17 GMT, Julia Lawall <julia=2Elawall@inria=2Efr> wr=
ote:
>
>
>On Wed, 20 Mar 2024, Dan Carpenter wrote:
>
>> On Tue, Mar 19, 2024 at 12:43:17PM -0700, Jakub Kicinski wrote:
>> > On Sat, 16 Mar 2024 12:44:40 +0300 Dan Carpenter wrote:
>> > > -	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
>> > > -	void *mac_buf __free(kfree);
>> > > +	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) =3D NULL;
>> > > +	void *mac_buf __free(kfree) =3D NULL;
>> >
>> > This is just trading one kind of bug for another, and the __free()
>> > magic is at a cost of readability=2E
>> >
>> > I think we should ban the use of __free() in all of networking,
>> > until / unless it cleanly handles the NULL init case=2E
>>
>> Free handles the NULL init case, it doesn't handle the uninitialized
>> case=2E  I had previously argued that checkpatch should complain about
>> every __free() pointer if the declaration doesn't have an assignment=2E
>>
>> The =3D NULL assignment is unnecessary if the pointer is assigned to
>> something else before the first return, so this might cause "unused
>> assignment" warnings?  I don't know if there are any tools which
>> complain about that in that situation=2E  I think probably we should ju=
st
>> make that an exception and do the checkpatch thing because it's such a
>> simple rule to implement=2E
>
>My understanding from Jonathan Cameron was that Linus wants a NULL always=
,
>unless there is an initialization with the declaration=2E

I don't have thread to hand but Linus strongly preferred moving any declar=
ation using this to
 where it is assigned so that it was obvious that the allocator and freer =
match=2E

Not checked if that makes sense here though=20
>
>julia

