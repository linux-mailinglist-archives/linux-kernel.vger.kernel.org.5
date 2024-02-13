Return-Path: <linux-kernel+bounces-64586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D09854092
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FCC8B29C52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C5F64CD9;
	Tue, 13 Feb 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D8Z9Vpbd"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8F633EA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868724; cv=none; b=RYHS81BgNJhUMtEla5d0t1pzbixnA0wfhmhv5iJQ8GBWVIWaFUYkJSTm9gBtD0zORL0a6Wfin4/6gTJh/RNZIVE3bIDeURahwfQntMWttuntKoIhEws+ec7H1wd3Osr/V7lNQIQisG8oMosBv7j0m4ARh2m8YAZHcfQENvXKy+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868724; c=relaxed/simple;
	bh=uiDuu22NBrFdQzH3YA0MyXOYknXtB3v73RinR/noGVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCMjrcozB8oQVgexBO120GGCFb0dsiSJGRXlRuJyPzEmMfRubwW4BEQqzuBKrdslWFRtJlBGTL9PbOHvryAOIzwkQ7l4vESe9HSvRFKxC7aWxokKabyd9Mi0AAEISvpR3670nbnfPbjuNENMGJoE/wjBI+fLK1HhxvKniZdcklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D8Z9Vpbd; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d10d2da73dso12989101fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707868719; x=1708473519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GwG0WTHtzxcENQR6iXPVmVJHnabo/OxCy/zykBA9mM=;
        b=D8Z9VpbdLiycx+XoRfQAs8s7Kp9x+Ms6SJPh73wB/X09Yx37ujcoQS0qy944O2RzEs
         HLwyXVobLyBkwznjugH5UqA/zOZx8zuZ+U0PwYyhbq5zbglbCXbN4Su9GTNp/njCCANS
         50cnYh75oQ2D0ULD9HmTi2JxI1huL0jq3RbGbhqt1Gos1DanYht8u5VJg0Sbj8gZ5QoV
         U/KwZuABitK1lMZooXQ8S58b7ied8rymgi5F3yciV/rEpwaV6ex0Vop/nvMvSfM+yhPE
         YyG02KTEI31ywNOxztp7evFpttmFzIWPPauaL5BvkvwAUZiU6LW4S7FPcIqenDdJrS0b
         u0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707868719; x=1708473519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GwG0WTHtzxcENQR6iXPVmVJHnabo/OxCy/zykBA9mM=;
        b=I6lEhnz9JJF9epuL28qdSEMy7zNcLOMBnrN8F6feZh22OI4FU883MCZzhhYav2gHDL
         2uztSvi0bj9r9HbnvBEd4jbd48BNbxKhLJ/Gjyu7m9SIOZ7SrtPrudLoXGVplTmTVAxl
         VXtwsG8XTE6rpOnVQnn3q6BJBKi8gRwFmel1H8aKaBf/jwQkcl8/IHX91R0fQz6vxebC
         pqRMHFAhmpbPeuPUANXZHua66WiMM268z2OL/Ofnq0SQ3vsTjpqKNVpoCTBABQ0SbYjI
         4UDqrECqGXiIdsi9HEbhXPy/jXDpxX+IpA6aJ4CUB0wMXGylO5tLZETS8K0TNVPfT+rY
         6RXw==
X-Forwarded-Encrypted: i=1; AJvYcCWWq3xuMZZAdOYPh9mc++hdRluq5OUd8+YewAc8WTi7yxHN+DSNtcbMIoJ3JSxyrxrvxMKR8AyQkHAf6rlCALrtGPqrVoiF5NHv5yd+
X-Gm-Message-State: AOJu0Ywg+e7V2icYQLWIv3+ipQmRZlXXznwpqMVVLchJynjwRySenpMo
	kD+cp/4Hf0MlU+XlYTj6k8c7f5mIcFZvRI/jyGo/NQjL9J6g24eEhHVEXAy9sWCSBF85bKkQHQg
	KjSsEJq/TQ7iUM4X0S/fswTsu30DteKiJci9F5Q==
X-Google-Smtp-Source: AGHT+IFbBzpSJQLUxUYOwvVVRI9nKUcjtcA4rvimCUjADh25eCyNBPMYM51cBRLulGAWZ1t0J1ZyR5PI3965Wj0Lw3c=
X-Received: by 2002:a2e:3306:0:b0:2d0:b646:3bc9 with SMTP id
 d6-20020a2e3306000000b002d0b6463bc9mr710721ljc.23.1707868719109; Tue, 13 Feb
 2024 15:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213081720.17549-1-ramona.gradinariu@analog.com> <20240213081720.17549-3-ramona.gradinariu@analog.com>
In-Reply-To: <20240213081720.17549-3-ramona.gradinariu@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Feb 2024 17:58:28 -0600
Message-ID: <CAMknhBFD54XotZrGeZK_48G=FDOWAr1vAf0pQwO=8o05jsTFRA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] docs: iio: add documentation for device buffers
To: Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:19=E2=80=AFAM Ramona Gradinariu
<ramona.gradinariu@analog.com> wrote:
>
> Add documentation for IIO device buffers describing buffer
> attributes and how data is structured in buffers using
> scan elements.

Really nice to see this being added to the docs.

>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
> changes in v4:
>  - documented multiple buffer support
>  - reworked scan elements section
>  - added reference to ABI docs
>  Documentation/iio/iio_devbuf.rst | 125 +++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst      |   1 +
>  2 files changed, 126 insertions(+)
>  create mode 100644 Documentation/iio/iio_devbuf.rst
>
> diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_dev=
buf.rst
> new file mode 100644
> index 000000000000..e99143efb4d7
> --- /dev/null
> +++ b/Documentation/iio/iio_devbuf.rst
> @@ -0,0 +1,125 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +Industrial IIO device buffers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +1. Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Industrial I/O core offers a way for continuous data capture based o=
n a
> +trigger source. Multiple data channels can be read at once from
> +/dev/iio:deviceX character device node, thus reducing the CPU load.

It could be nice to use inline code format style (double-backtick,
e.g. ``/dev/iio:deviceX``) on paths like this throughout the document.

> +
> +Devices with buffer support feature an additional sub-folder in the
> +/sys/bus/iio/devices/deviceX/ folder hierarchy, called bufferY, where Y =
defaults

Should this be `iio:deviceX` instead of `deviceX` to match the sysfs docs?

> +to 0, for devices with a single buffer.

Is /sys/bus/iio/devices/deviceX/buffer (without the Y) for backwards
compatibility?

> +
> +2. Buffer attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +An IIO buffer has an associated attributes directory under
> +/sys/bus/iio/iio:deviceX/bufferY/. The attributes are described below.
> +
> +Length
> +------

Could be nice to give the actual attribute name ``length`` here to
avoid possible case-sensitivity confusion with the section header.
Same applies to other attributes.

> +
> +Read / Write attribute which states the total number of data samples (ca=
pacity)
> +that can be stored by the buffer.
> +
> +Enable
> +------
> +
> +Read / Write attribute which starts / stops the buffer capture. This fil=
e should
> +be written last, after length and selection of scan elements.

Could be useful here to mention that writing a non-zero value here to
enable the buffer may result in an error, such as EINVAL, e.g. if an
invalid configuration was selected, like choosing a combination of
scan elements that don't match one of the valid scan masks.

> +
> +Watermark
> +---------
> +
> +Read / Write positive integer attribute specifying the maximum number of=
 scan
> +elements to wait for.
> +
> +Poll will block until the watermark is reached.
> +
> +Blocking read will wait until the minimum between the requested read amo=
unt or
> +the low water mark is available.
> +
> +Non-blocking read will retrieve the available samples from the buffer ev=
en if
> +there are less samples then watermark level. This allows the application=
 to
> +block on poll with a timeout and read the available samples after the ti=
meout
> +expires and thus have a maximum delay guarantee.
> +
> +Data available
> +--------------
> +
> +Read-only attribute indicating the bytes of data available in the buffer=
 In the
> +case of an output buffer, this indicates the amount of empty space avail=
able to
> +write data to. In the case of an input buffer, this indicates the amount=
 of data
> +available for reading.
> +
> +Scan elements
> +-------------
> +
> +The meta information associated with a channel reading placed in a buffe=
r is

Maybe say "data" instead of "reading" here since it could be writing
instead for DACs.

> +called a scan element. The scan elements are configurable per buffer, th=
us they
> +are exposed to userspace applications via the /sys/bus/iio/iio:deviceX/b=
ufferY/

Giving the directory again seems redundant here.

> +directory. The scan elements attributes are presented below.
> +
> +**_en**
> +
> +Read/ Write attribute used for enabling a channel. If and only if its va=
lue
> +is non zero, then a triggered capture will contain data samples for this
> +channel.
> +
> +**_index**
> +
> +Read-only positive integer attribute specifying the position of the chan=
nel in

Isn't 0 a valid scan index? So non-negative? Or unsigned?

> +the buffer. Note these are not dependent on what is enabled and may not =
be
> +contiguous. Thus for user-space to establish the full layout these must =
be used
> +in conjunction with all _en attributes to establish which channels are p=
resent,
> +and the relevant _type attributes to establish the data storage format.
> +

It would also be nice to get an example on the binary layout for
something that has multiple channels enabled. In particular with the
data alignment, e.g. when you have a 16-bit word followed by a 64-bit
word.


> +**_type**
> +
> +Read-only attribute containing the description of the scan element data =
storage
> +within the buffer and hence the form in which it is read from user space=
 Format
> +is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
> +
> +- **be** or **le** specifies big or little endian.
> +- **s** or **u**, specifies if signed (2's complement) or unsigned.
> +- **bits**, is the number of valid data bits.
> +- **storagebits**, is the number of bits (after padding) that it occupie=
s in the
> +  buffer.
> +- **repeat**, specifies the number of bits/storagebits repetitions. When=
 the
> +  repeat element is 0 or 1, then the repeat value is omitted.
> +- **shift**, if specified, is the shift that needs to be applied prior t=
o
> +  masking out unused bits.
> +
> +For example, a driver for a 3-axis accelerometer with 12 bit resolution =
where
> +data is stored in two 8-bits registers as follows:
> +
> +.. code-block:: bash

Doesn't look like this should use "bash" styling.

> +
> +          7   6   5   4   3   2   1   0
> +        +---+---+---+---+---+---+---+---+
> +        |D3 |D2 |D1 |D0 | X | X | X | X | (LOW byte, address 0x06)
> +        +---+---+---+---+---+---+---+---+
> +
> +          7   6   5   4   3   2   1   0
> +        +---+---+---+---+---+---+---+---+
> +        |D11|D10|D9 |D8 |D7 |D6 |D5 |D4 | (HIGH byte, address 0x07)
> +        +---+---+---+---+---+---+---+---+
> +
> +will have the following scan element type for each axis:
> +
> +.. code-block:: bash
> +
> +        $ cat /sys/bus/iio/devices/iio:device0/buffer0/in_accel_y_type
> +        le:s12/16>>4
> +
> +A user space application will interpret data samples read from the buffe=
r as two
> +byte little endian signed data, that needs a 4 bits right shift before m=
asking
> +out the 12 valid bits of data.

Is it always assumed that scan data is `raw` and needs to be
multiplied by `scale` for that channel to convert it to SI (or IIO
standard) units?

> +
> +Please see Documentation/ABI/testing/sysfs-bus-iio for a complete descri=
ption of
> +the attributes.

Is it also worth mentioning
``Documentation/ABI/testing/sysfs-bus-iio-dma-buffer`` here?

> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index db341b45397f..206a0aff5ca1 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -8,6 +8,7 @@ Industrial I/O
>     :maxdepth: 1
>
>     iio_configfs
> +   iio_devbuf
>
>  Industrial I/O Kernel Drivers
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> --
> 2.34.1
>
>

