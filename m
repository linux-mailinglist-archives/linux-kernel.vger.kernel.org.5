Return-Path: <linux-kernel+bounces-10843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCF181DCE3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 23:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB671C21483
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 22:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E3101E9;
	Sun, 24 Dec 2023 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="ehMeyW/9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BADF46
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1703457514; bh=LexBlyaT5TrlPpMhjrICCBx3k7EAdk/K799lHTtekGU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ehMeyW/9CBCL45jS6Ko4g1jUSfpxrH93yKB7CaUfucpTxeXHvwo6IjA2vZV4d8jlF
	 9j0XFDn02Tzp22P/T1HzUnATfqzh3OrPhshMwJgWpVFtGfYV5EyWmgB5t/vdH9u3JB
	 yjMEpfF1y0z40TR8rwuMNWoGQJbLCveZ+yKRgbso=
Date: Sun, 24 Dec 2023 23:38:32 +0100 (GMT+01:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <8e54a5e4-731f-4b37-97f8-2c65a026fd6f@t-8ch.de>
In-Reply-To: <20231224184402.of6cc2tczajmnbri@localhost>
References: <CGME20231220213032eucas1p2889cb35ee41ed155ce68e75b02892582@eucas1p2.samsung.com> <20231220-sysctl-check-v1-1-420ced4a69d7@weissschuh.net> <20231224184402.of6cc2tczajmnbri@localhost>
Subject: Re: [PATCH] scripts: check-sysctl-docs: adapt to new API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <8e54a5e4-731f-4b37-97f8-2c65a026fd6f@t-8ch.de>

Dec 24, 2023 19:44:42 Joel Granados <j.granados@samsung.com>:

> On Wed, Dec 20, 2023 at 10:30:26PM +0100, Thomas Wei=C3=9Fschuh wrote:
>> The script expects the old sysctl_register_paths() API which was removed
>> some time ago. Adapt it to work with the new
>> sysctl_register()/sysctl_register_sz()/sysctl_register_init() APIs.
>>
>> In its reference invocation the script won't be able to parse the tables
>> from ipc/ipc_sysctl.c as they are using dynamically built tables which
>> are to complex to parse.
>>
>> Note that the script is already prepared for a potential constification
>> of the ctl_table structs.
>>
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> ---
>> scripts/check-sysctl-docs | 42 ++++++++++++-----------------------------=
-
>> 1 file changed, 12 insertions(+), 30 deletions(-)
>>
>> diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
>> index 4f163e0bf6a4..bd18ab4b950b 100755
>> --- a/scripts/check-sysctl-docs
>> +++ b/scripts/check-sysctl-docs
>> @@ -8,7 +8,7 @@
>> # Example invocation:
>> #=C2=A0 scripts/check-sysctl-docs -vtable=3D"kernel" \
>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Documentation/admin-guide/sysctl/kernel.=
rst \
>> -#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(git grep -l register_sysctl_)
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(git grep -l register_sysctl)
>> #
>> # Specify -vdebug=3D1 to see debugging information
>>
>> @@ -20,14 +20,12 @@ BEGIN {
>> }
>>
>> # The following globals are used:
>> -# children: maps ctl_table names and procnames to child ctl_table names
>> # documented: maps documented entries (each key is an entry)
>> # entries: maps ctl_table names and procnames to counts (so
>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enumerating the =
subkeys for a given ctl_table lists its
>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 procnames)
>> # files: maps procnames to source file names
>> # paths: maps ctl_path names to paths
>> -# curpath: the name of the current ctl_path struct
>> # curtable: the name of the current ctl_table struct
>> # curentry: the name of the current proc entry (procname when parsing
>> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a ctl_tabl=
e, constructed path when parsing a ctl_path)
>> @@ -94,44 +92,24 @@ FNR =3D=3D NR {
>>
>> # Stage 2: process each file and find all sysctl tables
>> BEGINFILE {
>> -=C2=A0=C2=A0=C2=A0 delete children
>> =C2=A0=C2=A0=C2=A0=C2=A0 delete entries
>> =C2=A0=C2=A0=C2=A0=C2=A0 delete paths
> Why did you leave paths? As I read it you remove the use of paths and
> now this is not needed any longer.

Good catch, I'll drop it for V2.

>
>> -=C2=A0=C2=A0=C2=A0 curpath =3D ""
>> =C2=A0=C2=A0=C2=A0=C2=A0 curtable =3D ""
>> =C2=A0=C2=A0=C2=A0=C2=A0 curentry =3D ""
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (debug) print "Processing file " FILENAME
>> }
>>
>> -/^static struct ctl_path/ {
>> -=C2=A0=C2=A0=C2=A0 match($0, /static struct ctl_path ([^][]+)/, tables)
>> -=C2=A0=C2=A0=C2=A0 curpath =3D tables[1]
>> -=C2=A0=C2=A0=C2=A0 if (debug) print "Processing path " curpath
>> -}
>> -
>> -/^static struct ctl_table/ {
>> -=C2=A0=C2=A0=C2=A0 match($0, /static struct ctl_table ([^][]+)/, tables=
)
>> -=C2=A0=C2=A0=C2=A0 curtable =3D tables[1]
>> +/^static( const)? struct ctl_table/ {
>> +=C2=A0=C2=A0=C2=A0 match($0, /static( const)? struct ctl_table ([^][]+)=
/, tables)
> Would these regular expressions match lines that have more than one
> spaces before const?

No. But it is consistent with the other regexes.

>> +=C2=A0=C2=A0=C2=A0 curtable =3D tables[2]
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (debug) print "Processing table " curtable
>> }
>>
>> /^};$/ {
>> -=C2=A0=C2=A0=C2=A0 curpath =3D ""
>> =C2=A0=C2=A0=C2=A0=C2=A0 curtable =3D ""
>> =C2=A0=C2=A0=C2=A0=C2=A0 curentry =3D ""
>> }
>>
>> -curpath && /\.procname[\t ]*=3D[\t ]*".+"/ {
>> -=C2=A0=C2=A0=C2=A0 match($0, /.procname[\t ]*=3D[\t ]*"([^"]+)"/, names=
)
>> -=C2=A0=C2=A0=C2=A0 if (curentry) {
>> -=C2=A0=C2=A0 curentry =3D curentry "/" names[1]
>> -=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0 curentry =3D names[1]
>> -=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (debug) print "Setting path " curpath " to " cure=
ntry
>> -=C2=A0=C2=A0=C2=A0 paths[curpath] =3D curentry
>> -}
>> -
>> curtable && /\.procname[\t ]*=3D[\t ]*".+"/ {
>> =C2=A0=C2=A0=C2=A0=C2=A0 match($0, /.procname[\t ]*=3D[\t ]*"([^"]+)"/, =
names)
>> =C2=A0=C2=A0=C2=A0=C2=A0 curentry =3D names[1]
>> @@ -140,10 +118,14 @@ curtable && /\.procname[\t ]*=3D[\t ]*".+"/ {
>> =C2=A0=C2=A0=C2=A0=C2=A0 file[curentry] =3D FILENAME
>> }
>>
>> -/\.child[\t ]*=3D/ {
>> -=C2=A0=C2=A0=C2=A0 child =3D trimpunct($NF)
>> -=C2=A0=C2=A0=C2=A0 if (debug) print "Linking child " child " to table "=
 curtable " entry " curentry
>> -=C2=A0=C2=A0=C2=A0 children[curtable][curentry] =3D child
>> +/register_sysctl.*/ {
>> +=C2=A0=C2=A0=C2=A0 match($0, /register_sysctl(|_init|_sz)\("([^"]+)" *,=
 *([^,)]+)/, tables)
>> +=C2=A0=C2=A0=C2=A0 if (debug) print "Registering table " tables[3] " at=
 " tables[2]
>> +=C2=A0=C2=A0=C2=A0 if (tables[2] =3D=3D table) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (entry in entries[tables=
[3]]) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prin=
tentry(entry)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> }
>>
>> END {
>>
>> ---
>> base-commit: 1a44b0073b9235521280e19d963b6dfef7888f18
>> change-id: 20231220-sysctl-check-8802651d945d
>>
>> Best regards,
>> --
>> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>>
>
> --
>
> Joel Granados


