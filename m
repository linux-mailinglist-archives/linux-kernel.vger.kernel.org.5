Return-Path: <linux-kernel+bounces-29845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C34F83144B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E5A2857E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E028911716;
	Thu, 18 Jan 2024 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwCCmAkV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC813AF8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565643; cv=none; b=ODZ9BTNOmBKUU7lZZDOS9CIDaHR20CMZPr6R8fden+8MNPq9P32wjhpvQ6ix9Skkos7+h2y1ak8wckix9LitRdLojS3dFpBk7F4O7jbIoDPUVUA4hXtjd8IYH+KctMqG/tYJPTDNtlgZPeuWk/PIpPaOzdhnIBl1WNghyAEineQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565643; c=relaxed/simple;
	bh=VAdc1NKbCLJXB5ZwNWmpBl+bYEPBUTw+cW5ZgUWrUe4=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=tsvM5InUJtkdW/PbZu0DItlolq8DSTeIq2LBLTA+2NOZj35TgNV9RxJkOpTvFPDiAs6jty9DkCyKhxYEE9Lc8d9LkIw2lXwZ3VwvuKuGJj2g6DpUsECJhXQxGWoaFVdyHM/V1TNce9c0vIZXHIi5aCgzekxptFPtYJG4++hR6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwCCmAkV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705565639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SsqaeFnNlDjnwQj4dzfPpX8ZsfHI+luLg/Td8wcFQ4=;
	b=MwCCmAkVufJFzH9Z3YqgOl7D9xa8dpaBbzzj9sIjhmObvrvR1eUwP6AbmxUCSKrlc5bGMi
	nMFx5EB+Uu59QfPZpwawXgbUHlZaPnKlgupCy9+5t8xYSe96IKd2pa9pBZmxdKRDIG8q5V
	oIkP/dCXNn5eUS2vNdoOaa3aCeeXg4A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-r_XrlEscNA6F2ZA678WIuA-1; Thu, 18 Jan 2024 03:13:57 -0500
X-MC-Unique: r_XrlEscNA6F2ZA678WIuA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-558b04cb660so3559564a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705565636; x=1706170436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SsqaeFnNlDjnwQj4dzfPpX8ZsfHI+luLg/Td8wcFQ4=;
        b=JIc+jSM/RB2TgBc3DX1Qudqu31HL82DX659sX7VvvoWRMVr7eHG1ZLgzfyj8ASNVnJ
         Vaz9s0bXSNipoBwwhMjH/QpMdOeDay1Np+Cnwj/NDsa7vgAuhxOWjAcxbvsFFDqZugp6
         4Rmjc3ZOhMcVJpDkbr7kokfEKOOveIiz37B4jVYkb6Qtss5BMxvsalOUKQd3AUBzK4ex
         A4Y8hiHAp7OKPMcbWThl6GNnmGxcqC7YPfnTfFrTr/363B4TxtnpfpCokpXtGn8Zce6u
         68MdYBvWtOzP/QIQ7KcHjfrDXfY9wVrdac1CK1NuilKOKTEMcKBBDos8+d3pQIVcizPb
         njFA==
X-Gm-Message-State: AOJu0YwFwvPFGzwctHnElGUrFOtsPnuT6jfCVJVax0ftEkdy6VLLqg9S
	uWMzA7gg4T93RpwmSooiQSHYGVqPHZBHZ6DALeI4CIc0kfRIx5FJwAYN8nh3gQmyrqEYvhISC6N
	TVlHeKNL/Wx96/JkmbV1F4IhkiHDlUTfbPy9V/faOG0W7aj9MKSA6/lfRYBo0lmIOd25opGBGH/
	fMP+5dsE71jvjgBMc6MWn5qU0tEoq0BLWsd1xW
X-Received: by 2002:a17:906:f746:b0:a26:97fe:b8cc with SMTP id jp6-20020a170906f74600b00a2697feb8ccmr266444ejb.66.1705565636476;
        Thu, 18 Jan 2024 00:13:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC3cI8HvUGHgz6IrmlJYZMRWTXEOiyQ0Xwp7Yv8XXR/9cy35jOph4av3RGpi+WCBaGGtcY/I8OUZfAk0dVXVw=
X-Received: by 2002:a17:906:f746:b0:a26:97fe:b8cc with SMTP id
 jp6-20020a170906f74600b00a2697feb8ccmr266431ejb.66.1705565636180; Thu, 18 Jan
 2024 00:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-wip-wacom-tests-fixes-v1-1-f317784f3c36@kernel.org> <CANRwn3QhYtuiGemwrf6_bYDDeAU0GrPm7T9ca3OzQaX8vGKPEQ@mail.gmail.com>
In-Reply-To: <CANRwn3QhYtuiGemwrf6_bYDDeAU0GrPm7T9ca3OzQaX8vGKPEQ@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 18 Jan 2024 09:13:44 +0100
Message-ID: <CAO-hwJ+n7Bv8UgNaDCEtqoU=DWVxxVUJ7y+=nj_PKmrdtgorkA@mail.gmail.com>
Subject: Re: [PATCH] selftests/hid: wacom: fix confidence tests
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jason Gerecke <jason.gerecke@wacom.com>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 7:12=E2=80=AFPM Jason Gerecke <killertofu@gmail.com=
> wrote:
>
> LGTM. Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Thanks!

I'll add a:
Fixes: b0fb904d074e ("HID: wacom: Add additional tests of confidence behavi=
or")

And send to Linus in the next round for 6.8 so we also fix the future
for-6.9 branches

Cheers,
Benjamin


>
>
> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can=E2=80=99t take seven from three,    /
> So you look at the sixty-fours....
>
>
>
> On Wed, Jan 17, 2024 at 5:27=E2=80=AFAM Benjamin Tissoires <bentiss@kerne=
l.org> wrote:
>>
>> The device is exported with a fuzz of 4, meaning that the `+ t` here
>> is removed by the fuzz algorithm, making those tests failing.
>>
>> Not sure why, but when I run this locally it was passing, but not in the
>> VM.
>>
>> Link: https://gitlab.freedesktop.org/bentiss/hid/-/jobs/53692957#L3315
>> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>> ---
>> Over the break the test suite wasn't properly running on my runner,
>> and this small issue sneaked in.
>> ---
>>  tools/testing/selftests/hid/tests/test_wacom_generic.py | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/t=
ools/testing/selftests/hid/tests/test_wacom_generic.py
>> index 352fc39f3c6c..b62c7dba6777 100644
>> --- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
>> +++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
>> @@ -880,8 +880,8 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.Tes=
tMultitouch, TouchTabletTest
>>          does not overlap with other contacts. The value of `t` may be
>>          incremented over time to move the point along a linear path.
>>          """
>> -        x =3D 50 + 10 * contact_id + t
>> -        y =3D 100 + 100 * contact_id + t
>> +        x =3D 50 + 10 * contact_id + t * 11
>> +        y =3D 100 + 100 * contact_id + t * 11
>>          return test_multitouch.Touch(contact_id, x, y)
>>
>>      def make_contacts(self, n, t=3D0):
>> @@ -902,8 +902,8 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.Tes=
tMultitouch, TouchTabletTest
>>          tracking_id =3D contact_ids.tracking_id
>>          slot_num =3D contact_ids.slot_num
>>
>> -        x =3D 50 + 10 * contact_id + t
>> -        y =3D 100 + 100 * contact_id + t
>> +        x =3D 50 + 10 * contact_id + t * 11
>> +        y =3D 100 + 100 * contact_id + t * 11
>>
>>          # If the data isn't supposed to be stored in any slots, there i=
s
>>          # nothing we can check for in the evdev stream.
>>
>> ---
>> base-commit: 80d5a73edcfbd1d8d6a4c2b755873c5d63a1ebd7
>> change-id: 20240117-b4-wip-wacom-tests-fixes-298b50bea47f
>>
>> Best regards,
>> --
>> Benjamin Tissoires <bentiss@kernel.org>
>>
>>


