Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71267764927
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjG0Hoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjG0HnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:43:21 -0400
Received: from wp534.webpack.hosteurope.de (wp534.webpack.hosteurope.de [80.237.130.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7A36A5B;
        Thu, 27 Jul 2023 00:37:30 -0700 (PDT)
Received: from [2001:a61:6209:7f40:c80a:ff:fe00:4098] (helo=cs-office3.lan.local); authenticated
        by wp534.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qOvXS-0001KS-TP; Thu, 27 Jul 2023 09:35:58 +0200
Date:   Thu, 27 Jul 2023 09:35:28 +0200
From:   Carsten =?UTF-8?B?U3BpZcOf?= <mail@carsten-spiess.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Message-ID: <20230727093528.594ce3a7.mail@carsten-spiess.de>
In-Reply-To: <f8fdc8d7-6ac5-5e20-10ef-7417d79c1b91@roeck-us.net>
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
 <f8fdc8d7-6ac5-5e20-10ef-7417d79c1b91@roeck-us.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e/q7Xi+4mzcxvn1ecSyofAo";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-bounce-key: webpack.hosteurope.de;mail@carsten-spiess.de;1690443451;3e94405d;
X-HE-SMSGID: 1qOvXS-0001KS-TP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e/q7Xi+4mzcxvn1ecSyofAo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

thanks all for your input.
I conclude here in one answer:

On 7/26/23 18:14, Krzysztof Kozlowski wrote:
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
sorry i missed that, fixed for [Patch v2].


On 7/26/23 18:14, Krzysztof Kozlowski wrote:
>> +  shunt-gain: =20
> 1. Missing vendor prefix (does not look like generic property)
> 2. -microvolt
> And then enum is for 40, 80, 160 and 320.
replaced with
  renesas,shunt-range-milli-volts:
    description: |
      maximal shunt voltage range of 40mV, 80mV, 160mV or 320mV
    $ref: /schemas/types.yaml#/definitions/uint32-array
    default: 320
    enum: [40, 80, 160, 320]

On 26/07/2023 18:16, Guenter Roeck wrote:
>> +  shunt-resistor-micro-ohms:
>> +    description:
>> +      Shunt resistor value in micro-Ohm
>> +      defaults to <0> when not set
>> +      monitoring of current and power not supported when <0>
> + =20
> Should not default to 0 (disabled).
When shunt resistor value is not known, current and power calculation can n=
ot be done,
but the shunt voltage still can be measured.
As the resistor is externaly connected to the ISL28022 chip there is no def=
ault.
When i set default to any value (e.g 1000 micro Ohm), current and power cal=
culation
will give wrong results (except when the shunt _is_ 1000 micro Ohm)

On 26/07/2023 18:16, Guenter Roeck wrote:
>> +  average:
>> +    description: |
>> +      Number of samples to be used to report voltage, current and power=
 values.
>> +      defaults to <0> when not set
>> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128] =20
> Should not default to 0 (disabled).
=46rom datasheet table 6 on page 15 there are two similar ADC modes:
  3 - without samples
  8 - with one? sample
I intended enum 0 to ADC mode 3, 1 to ADC mode 8,
but i can live without ADC mode 3.

On 26/07/2023 20:59, Guenter Roeck wrote:
> On 7/26/23 11:27, Krzysztof Kozlowski wrote: =20
>> On 26/07/2023 20:19, Guenter Roeck wrote: =20
>>>>> +  average:
>>>>> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128] =20
>>>>
>>>> I am sure hwmon has some property for this. Are you sure it is called
>>>> "average"?
>>>> =20
>>>
>>> Something with samples. adi,power-sample-average is similar. Others
>>> use average-samples, qcom,avg-samples, touchscreen-average-samples. =20
>>
>> So probably it's a time to come with something generic, e.g.:
>> average-samples in some hwmon.yaml

As there's no generic yet, replaced with
  renesas,average-samples:
    description: |
      Number of samples to be used to report voltage, current and power val=
ues.
    default: 1
    $ref: /schemas/types.yaml#/definitions/uint32-array
    enum: [1, 2, 4, 8, 16, 32, 64, 128]



On 26/07/2023 19:13, Rob Herring wrote:
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
Fixed for [Patch v2], runs without errors or warnings

Regards, Carsten

--Sig_/e/q7Xi+4mzcxvn1ecSyofAo
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWM+MlUpz/bWsZllTM1JQzV9LKSwFAmTCHkAACgkQM1JQzV9L
KSw/sQ//YfEBYzZ21ij/3yDpY81XyOVnjsICovJPxeClmxPbvA92RC+q9v+k8a+7
jcAvaTKVr8gFeMoUQe9jQ6br9M+tx8TH3CzWW8oGw7dSWCr+y6yofqeAGxpSuL9V
Hce6sEe//lQgHgVWUaqVHmo4jJBY2RsBBJuNHYz45noRv/ESekq+vnIgKyERlpcQ
/bwwdO/nEyR76sNsPyMXepaipRjKsRDZA+0RysCAby3D8MDf+e7nIvUhgyvt37ne
dpI78cEJ05JF7ZYvXUfXC2q67Qr6VsaNwsDVaXEFxA//Cy88rVlSb/bN70qoSutf
3pwczGGln9vJNx7dG6fgXSo0o3QZKC/ifCfey7nkVbKonBIKvNhoJKeGBrO4ETIG
c3yZ69O1Sb+hdinXrOXTjBFciieSP4OIqUnHBSywNjM+u1WmAaP3tt6GgyXMu84X
A1K9hgmD/1cbbBabFTa750LEud/q17OU+B9h+IiS2nARWDEvjl2cWKB290s3AFP7
wjmdr3FCczVTRq1OpbwLieromZ6yaiXfgTJXenhclaHo3lh7n+LGOiSMT0MIDs4Z
iV/X06ad6wzp1AfgSdtOYhtJL6Z+RZoJoRqoTD6E2Wzl5uYZrv5BbjIdFm2C1qEw
uwZmK6aGVmGMiTt9XuhjIExWzt06krZRtbFtUh27R8xsASXk6qw=
=KFij
-----END PGP SIGNATURE-----

--Sig_/e/q7Xi+4mzcxvn1ecSyofAo--
