Return-Path: <linux-kernel+bounces-51933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632B849195
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B493F1C21D09
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF1BE5A;
	Sun,  4 Feb 2024 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPG5QINK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1A10A17;
	Sun,  4 Feb 2024 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089269; cv=none; b=ebpqdz+j8UerWUu+PRt2QK7du1I37THoacLedfb3IKPUez2yu96TUlrRyU+qjj6rudrQ0sE0BvakZA0rX6bEY43gWUuWOMGTHsUppw5JYSeMI6NxkopNRHdTOsrGtxqAk/MyyZa/MhF9Ub8I+4VDfYibSaBhE0ifW2VQouI5iD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089269; c=relaxed/simple;
	bh=FyxVXH32tZCaAHP4EmkysStz1copuK/ihQZAm7t1jvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TFEHGmZwp4i5r6BC3cSAd7aBWFgSgVYXzti0FZcjccz1ykgUxcPhrjjKee0I5HfxgQu1Dya0gs7gca9eqEL7YlOWWrQTN/N590e9IluYyB0S/fsDnIAPuYUNgVq0fSrPEFWAKsqRYvi+BMNdOsRAnrSi8XoLHkW5StN9y3aI/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPG5QINK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d91397bd22so29101085ad.0;
        Sun, 04 Feb 2024 15:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089267; x=1707694067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBEcJ8v9Rwu5kLCMTmYWLQBjPaSMqtVsHINMD5JdFFk=;
        b=IPG5QINKkq5bFlpYirTUDi4Sead3eFDNaUPZgz0lol3U92DZXxjbAuG7LWHLvKb960
         F3OEYf+8pz2epwzFS00oN6dzRSbJrWr1XleKTVNHAJssVsP5jwniX+gqmqVM9UHMmeJy
         LD4MD8Ew3TB2ohrhi1vHYRuXG5l3J8tjQ8ZkDNVOrqW2ejNJNHSmWFI7KU9WhpKIvX2t
         3R8QGMAnZd1u2dG/xOeKYQy5J1dn9wP3kf4dcJDUdZnN2RnepsT6MggoiVjWcydJL0TP
         HRjCtpyHhYTTZl6WrLSxVGOp1DWYSEaAOSD164PQVTKrmwI0/bYUrwJGPbHU7vAZjv/l
         BisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089267; x=1707694067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBEcJ8v9Rwu5kLCMTmYWLQBjPaSMqtVsHINMD5JdFFk=;
        b=XCMtrBdoVhie3w/OcMTzlthwYPPsyIfiX+JClvHI1FyMavwsmhsmXwXJDjYGonEGNF
         HA74LfW/U/Eu/hooah/vTu1RaJplA+Hr6uPVjBAxSMI+q1ehwaEiYNHPHzApNKxfzlaJ
         XOjqjci9DDLU0j6K8wRo+nU6/mm/QkWGNI/k7QoFVMfqI1+2lP0jEVcaMoGBUTSw/Up9
         yNoyr5ux+/yHvG5hwqqp6UepLfQZXvlpLn1ADZkqusp77kMSSQUhdFpG4fA466ERdiJk
         oyfa1EYhKBsCcaVq+wEoKT4sm+bavOUAMARU79QzkjbwCsK3v7nBomo0oaSMP7c39oUu
         SmVA==
X-Gm-Message-State: AOJu0Yz4/cJw/sQD6+ONrFQjxXbbDgu8o6KgsVQjVZl+INN3fNNG559Z
	FHWp3G2rQbX5kyI0i15uO0aKaZfnWbw0JARAMapGsyKwA7PFYHgo
X-Google-Smtp-Source: AGHT+IEPgzWf3vCqIYIcdfhFGs2vrzIUgrNU8RfYBsbVTa51k1WkZAjTb8xn8MycTjWhD+NEA7WPRQ==
X-Received: by 2002:a17:902:b497:b0:1d9:9e4f:c0d5 with SMTP id y23-20020a170902b49700b001d99e4fc0d5mr3029947plr.40.1707089266613;
        Sun, 04 Feb 2024 15:27:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV1K1jKM8C59YAtCC6gk3DKkgpsgDGqWvwO/RH10kWkJTAnoHuxGTi1Gvi0km/GYcc+H/Q3OicJ9/dmInxd6mgtq21ybFCJSYkjkZLhhHcfaNq7Vddjcwv2uzUfyU6UzLf6fT0w6P0ZhfJ4CpWqp8Mioqk9amvhJl9AUFvgehy0fmGDaFQn2OWdHgRDtOaiAGqLzi6oUJxFBA==
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902c98a00b001d95eebffaesm5022168plc.88.2024.02.04.15.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:27:46 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org
Subject: [PATCH net-next v3 0/8] netconsole: Add userdata append support
Date: Sun,  4 Feb 2024 15:27:31 -0800
Message-ID: <20240204232744.91315-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Add the ability to add custom userdata to every outbound netconsole message
as a collection of key/value pairs, allowing users to add metadata to every
netconsole message which can be used for  for tagging, filtering, and
aggregating log messages.

In a previous patch series the ability to prepend the uname release was
added towards the goals above. This patch series builds on that
idea to allow any userdata, keyed by a user provided name, to be
included in netconsole messages.

If CONFIG_NETCONSOLE_DYNAMIC is enabled an additional userdata
directory will be presented in the netconsole configfs tree, allowing
the addition of userdata entries.

    /sys/kernel/config/netconsole/
			<target>/
				enabled
				release
				dev_name
				local_port
				remote_port
				local_ip
				remote_ip
				local_mac
				remote_mac
				userdata/
					<key>/
						value
					<key>/
						value
          ...


v1->v2:
 * Updated netconsole_target docs, kdoc is now clean
v2->v3:
 * Remove inline keyword from to_userdat* functions
 * Break up some lines that exceeded 80 chars
 * Replace typos and remove {} from single line if statement
 * Remove unused variable

Testing for this series is as follows:

Build every patch without CONFIG_NETCONSOLE_DYNAMIC, and also built
with CONFIG_NETCONSOLE_DYNAMIC enabled for every patch after the config
option was added

Test Userdata configfs

    # Adding userdata
    cd /sys/kernel/config/netconsole/ && mkdir cmdline0 && cd cmdline0
    mkdir userdata/release && echo hotfix1 > userdata/release/value
    preview=3D$(for f in `ls userdata`; do echo $f=3D$(cat userdata/$f/valu=
e); done)
    [[ "$preview" =3D=3D $'release=3Dhotfix1' ]] && echo pass || echo fail
    mkdir userdata/testing && echo something > userdata/testing/value
    preview=3D$(for f in `ls userdata`; do echo $f=3D$(cat userdata/$f/valu=
e); done)
    [[ "$preview" =3D=3D $'release=3Dhotfix1\ntesting=3Dsomething' ]] && ec=
ho pass || echo fail
    #
    # Removing Userdata
    rmdir userdata/testing
    preview=3D$(for f in `ls userdata`; do echo $f=3D$(cat userdata/$f/valu=
e); done)
    [[ "$preview" =3D=3D $'release=3Dhotfix1' ]] && echo pass || echo fail
    rmdir userdata/release
    preview=3D$(for f in `ls userdata`; do echo $f=3D$(cat userdata/$f/valu=
e); done)
    [[ "$preview" =3D=3D $'' ]] && echo pass || echo fail
    #
    # Adding userdata key with too large of 6.7.0-rc8-virtme,12,481,1795410=
4,-directory name [<54 chars]
    mkdir userdata/testing12345678901234567890123456789012345678901234567890
    [[ $? =3D=3D 1 ]] && echo pass || echo fail
    #
    # Adding userdata value with too large of value [<200 chars]
    mkdir userdata/testing
    echo `for i in {1..201};do printf "%s" "v";done` > userdata/testing/val=
ue
    [[ $? =3D=3D 1 ]] && echo pass || echo fail
    rmdir userdata/testing

- Output:

    pass
    pass
    pass
    pass
    pass
    mkdir: cannot create directory =E2=80=98cmdline0/userdata/testing123456=
78901234567890123456789012345678901234567890=E2=80=99: File name too long
    pass
    bash: echo: write error: Message too long
    pass

Test netconsole messages (w/ msg fragmentation)

    echo `for i in {1..996};do printf "%s" "v";done` > /dev/kmsg

- Output:

    6.7.0-rc8-virtme,12,484,84321212,-,ncfrag=3D0/997;vvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv6.7.0-rc8-virtme,12,484,84321212,-,ncfrag=3D=
952/997;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

Test empty userdatum

    cd /sys/kernel/config/netconsole/ && mkdir cmdline0
    mkdir cmdline0/userdata/empty
    echo test > /dev/kmsg
    rmdir cmdline0/userdata/empty

- Output:

Test netconsole messages (w/o userdata fragmentation)

    cd /sys/kernel/config/netconsole/ && mkdir cmdline0
    mkdir cmdline0/userdata/release && echo hotfix1 > cmdline0/userdata/rel=
ease/value
    mkdir cmdline0/userdata/testing && echo something > cmdline0/userdata/t=
esting/value
    echo test > /dev/kmsg
    rmdir cmdline0/userdata/release
    rmdir cmdline0/userdata/testing

- Output:
    6.7.0-rc8-virtme,12,500,1646292204,-;test
    release=3Dhotfix1
    testing=3Dsomething

Test netconsole messages (w/ long body fragmentation)
    cd /sys/kernel/config/netconsole/ && mkdir cmdline0
    mkdir cmdline0/userdata/release && echo hotfix1 > cmdline0/userdata/rel=
ease/value
    mkdir cmdline0/userdata/testing && echo something > cmdline0/userdata/t=
esting/value
    echo `for i in {1..996};do printf "%s" "v";done` > /dev/kmsg
    rmdir cmdline0/userdata/release
    rmdir cmdline0/userdata/testing

- Output:
    6.7.0-rc8-virtme,12,486,156664417,-,ncfrag=3D0/1031;vvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv6.7.0-rc8-virtme,12,486,156664417,-,ncfrag=
=3D950/1031;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    release=3Dhotfix1
    testing=3Dsomething

Test netconsole messages (w/ long userdata fragmentation)

    cd /sys/kernel/config/netconsole/ && mkdir cmdline0
    LOREM=3D"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut"
    for i in {0..5}; do mkdir cmdline0/userdata/value${i} && echo ${LOREM} =
> cmdline0/userdata/value${i}/value; done
    echo test > /dev/kmsg
    for i in {0..5}; do rmdir cmdline0/userdata/value${i}; done

- Output:
    6.7.0-rc8-virtme,12,487,221763007,-,ncfrag=3D0/1241;test
    value0=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut
    value1=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut
    value2=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut
    value3=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut
    value4=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magn6.7.0-rc8-virtme,12,487=
,221763007,-,ncfrag=3D950/1241;a aliqua. Ut enim ad minim veniam, quis nost=
rud exercitation ullamco laboris nisi ut
    value5=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut


Matthew Wood (8):
  net: netconsole: cleanup formatting lints
  net: netconsole: move netconsole_target config_item to config_group
  net: netconsole: move newline trimming to function
  net: netconsole: add docs for appending netconsole user data
  net: netconsole: add a userdata config_group member to
    netconsole_target
  net: netconsole: cache userdata formatted string in netconsole_target
  net: netconsole: append userdata to netconsole messages
  net: netconsole: append userdata to fragmented netconsole messages

 Documentation/networking/netconsole.rst |  66 +++++
 drivers/net/netconsole.c                | 359 ++++++++++++++++++++----
 2 files changed, 370 insertions(+), 55 deletions(-)

--
2.43.0


