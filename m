Return-Path: <linux-kernel+bounces-107880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5698802E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578312851B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AE72033E;
	Tue, 19 Mar 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=acm.org header.i=@acm.org header.b="k1SmjNW5"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98381804A;
	Tue, 19 Mar 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867682; cv=none; b=m4IyizvAmWsZMGb/63Njah/Qd1ld2v5/ine9BU+ALBl2xuQbyKMTeElWcNSi8qHdkCIHUAMGodXhKdXWHic0EZQdo5VEssW3x+XAnb1MTrI5X4wmqTvweD95codtjmAFOvVAmHb1EBUUY8aNjSgZ3me6AkkVua6J3jhSMeFVleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867682; c=relaxed/simple;
	bh=s3VmWNpfRoSZzBqlkyzepBdDQAjaNpifveoVLpt85ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1YGyVh1OZVlMQfd9ND/HxzD+9zdOWebzdPXljIv8z1UEmqXInwRTq/59muzTNM+IG90D76od+AAeUPBT0KIWYgFameWUQ8tLMgUFxdW29MX2wTgMcRnBqPQeLQEYvdZiy6mHbXxxl8fSICm0naRRYFPljtMgvt8yUIVfnyknpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=k1SmjNW5; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4TzdKX0pysz6Cnk94;
	Tue, 19 Mar 2024 17:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710867675; x=1713459676; bh=DMTMB9/LAk5BGlCUtQsC4r4k
	TvUuJ3sSt9k1EF9/RXM=; b=k1SmjNW5Ylm3wDLl7V8YVhob5mr93GJ2s9k5EAJ5
	tdcX8ptPHTa4C4sJ+AvtMSPpYCp1O4hAHwtc+ES5OdwWXFAKCkaIJSsFllyVOxqM
	VuJy2LD7qJmQ75oeLEdjiFun07EOfrCj+y3KzSl0Wxxb2CRNGwqlpiDwQPYOc1B2
	9B+5RUwEnmAXPvk1ozOLGuvEH1YSkB+EoXtQHM89/4ghh+SHEQQ2akX+wTwLO4Up
	Oq1004nSOqVpq4UXlVSmERVGU2Q51sbjQ3KmiTKO70DZ4GiJUs2+6/9xCIZgC6nY
	zV7pZn4OOUjQUAA76FfEX0QWBzV7KvJLOpQBMzqSQzknrQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9YE-69ygPJXO; Tue, 19 Mar 2024 17:01:15 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4TzdKP6t2Kz6Cnk8y;
	Tue, 19 Mar 2024 17:01:13 +0000 (UTC)
Message-ID: <0d41ae1a-f6aa-4377-b8a3-7fcf067f99ac@acm.org>
Date: Tue, 19 Mar 2024 10:01:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: core: Make scsi_lib KUnit tests modular for real
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mike Christie <michael.christie@oracle.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <48ca5e827ca420bbdbabb1643e2179dc95c9e0b7.1710849638.git.geert@linux-m68k.org>
 <d1a1b0b8-41f1-4ead-b393-d8d2f099b0c4@acm.org>
 <CAMuHMdWzD1OR8qj8oHfUgQ9GMtrD8y69G+A+ONdVm0vTCvYe=w@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAMuHMdWzD1OR8qj8oHfUgQ9GMtrD8y69G+A+ONdVm0vTCvYe=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/19/24 09:10, Geert Uytterhoeven wrote:
> On Tue, Mar 19, 2024 at 5:03=E2=80=AFPM Bart Van Assche <bvanassche@acm=
org> wrote:
>> On 3/19/24 05:02, Geert Uytterhoeven wrote:
>> kernel module? What are the advantages compared to the current approac=
h?
>> That information is missing from the patch description.
>=20
> SCSI_LIB_KUNIT_TEST is already tristate, so the original author must
> have meant it to be modular.  Or perhaps he just copied it from
> (most/all) other tests ;-)
>=20
> Anyway, I find it very useful to be able to do "modprobe kunit" and
> "modprobe <test>" to run a test when I feel the need to do so.

Hi Geert,

Why to run hardware-independent kunit tests on the target system instead
of on the host? Isn't it much more convenient when developing embedded
software to run kunit tests on the host using UML? The script I use to
run SCSI kunit tests is available below. And if there is a desire to run
SCSI tests on the target system, how about adding triggers in sysfs for
running kunit tests? The (GPL v2) Samsung smartphone kernel supports
this but I have not yet checked whether their implementation is
appropriate for the upstream kernel.

Thanks,

Bart.


#!/bin/sh

set -e

mkdir -p .kunit
if [ -e .config ]; then
     rm -f .config
     make ARCH=3Dum mrproper
fi
if [ ! -e .kunit/.kunitconfig ] || [ "$0" -nt .kunit/.kunitconfig ]; then
     echo "Regenerating .kunit/.kunitconfig"
     cat <<EOF >.kunit/.kunitconfig
CONFIG_BLK_DEV_SD=3Dy
CONFIG_BLK_DEV_ZONED=3Dy
CONFIG_MQ_IOSCHED_DEADLINE=3Dy
CONFIG_BLOCK=3Dy
CONFIG_EISA=3Dn
CONFIG_KUNIT=3Dy
CONFIG_SCSI_PROCFS=3Dn
#CONFIG_PROVE_LOCKING=3Dy
CONFIG_SCSI=3Dy
#CONFIG_SYSFS=3Dy
CONFIG_UBSAN=3Dy
CONFIG_KASAN=3Dy
CONFIG_RUNTIME_TESTING_MENU=3Dn
CONFIG_WERROR=3Dy
EOF
     syms=3D(
	CONFIG_SCSI_ERROR_TEST
	CONFIG_SCSI_PROTO_TEST
	CONFIG_SCSI_SD_TEST
     )
     for s in "${syms[@]}"; do
     if git grep -qw "${s#CONFIG_}" block/Kconfig* drivers/scsi/Kconfig;=20
then
	echo "$s=3Dy" >> .kunit/.kunitconfig
     fi
     done
     cp .kunit/.kunitconfig .kunit/.config
fi
/tools/testing/kunit/kunit.py run

