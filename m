Return-Path: <linux-kernel+bounces-64944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933688544F6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B490283E25
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC112B61;
	Wed, 14 Feb 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ZjhltYGT"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF579DC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902430; cv=none; b=R7gXzTQcw0ebsRwgRWmVy0Bj8o/MPo1WG29oONPdvA2Z8lTWWM5brrrRwyhpqYT4pjZ+RbOZBfePbUcgPwUJZmk37mynjX6TPImIpkE/dkK7t7cx6VLZEF4GBsphRSp2iSk5q+R3rAYlLLo1XBIzXB9X/HJ6GlN2rdIDavq01E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902430; c=relaxed/simple;
	bh=0fPdwZNsLS69Huv0I8sGB5yfphGY07GmyJfHv2XPGbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVslp1O+W+gF6f3inIQZRO0rBQg2ybmnbM1Kqg5eDHaW4AQ/APwIU6VChP1NQPYwZ7zjZU2EYCvpdJql57r6LVS8jK1i1git0VqlZDKhEBUM2+0IDeinbj9gAFFWBUs6gvN4rAQ/DabRxCITur/r4AYAbP/Ze0N0O4egWK8eJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=ZjhltYGT; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso4547755a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707902428; x=1708507228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/19sQ4pxsIEJ7YhUTf9YS+0MW22psDvn0EMZBCLo3mk=;
        b=ZjhltYGTVFW/g0qD2ou35mpUYmqS5TwtdloGQotPG/ilfFoKamJnKA5W8BYCXw53Z+
         Pxf/cQtpi5i7HW23gtki9JNSZcKO8uLCaxoZPEqTHcJwVZSU8tsVTyDD03BwHscBYeiR
         c4B37vd5FQrqrRQ2YWpeSyhP2fgSymdk+zxhSSKFqK3eGqWnxSREUSaUV1KHny7wPG5k
         jpCyWipLW4pQlq91+CUW94WNEEguVXrXZeWs4vLfyslixbK8n7hnaDYbeCoMiiMHhVRC
         ug+H/ESwleyOkswRjtdJ0vvhc0OGzFw7w9HOyLJQDxKAqtlYDcP6j+gozg31XvE10WWd
         z4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902428; x=1708507228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/19sQ4pxsIEJ7YhUTf9YS+0MW22psDvn0EMZBCLo3mk=;
        b=lMeOHUpSC2quE0MEzh7rPJWl75GfwEprWAzLdXuwjk6Kcn9nDHcGNrcZT/7w4ELnCe
         BWcnVLc/jQpELiCbNrylWnoXL2WBAozOW5/IwqH6stojY0OLc3NfRw5l2B16nJgbpVMr
         zThqVCPSTgurOAUJA2x01CZShBwJgBDxgVmavqcPtvuepxJhAqXhGGBBOeT83hxs6GBE
         ZfVGdk6esD6D+HjsmCgsXqOlFVR8581djQAzL4vsZ0D/dIOJn7wvqoixWbYZ2vHM5yNn
         +iZZn0KJakUpcHHP33GqkPffPSyD27UdMv1M7xMGOUJH0KKvJqETkCevRVJQ+FLLF7Il
         l4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVHQ/tgJKATEYHfGqMBVqURvbfSgMVXN8DfXfB+q/8bcHdl3bZl/y89NK+3R30wBA4CGCO1mrU9iZjW81q3RUe2l2pIzLI7b54C8y+g
X-Gm-Message-State: AOJu0YwmqnfbV0Ykc//074sztY+n+ne7hgN3H2FpgmB1pOi+b64wppqc
	shI+AXbuWeozPHU/qO2iFQzuaV+foG3/cCTJ8oJJEG5gl559l9YHs14uU5YaMCcPDOwMWbwEkwI
	dDZOlwcrA8bAm07W8HepKr9iOsP3Ml1ndq9+w3A==
X-Google-Smtp-Source: AGHT+IGDrwWoVvQYVO4/41/tvlZknFSKtr/BQBfPcXc3+069y5dQgY8zPFO+V46/qc98bY82C+ghHupMVL7+PS4S9YY=
X-Received: by 2002:a05:6a20:4e21:b0:19e:9ae1:a2ad with SMTP id
 gk33-20020a056a204e2100b0019e9ae1a2admr1675398pzb.60.1707902427996; Wed, 14
 Feb 2024 01:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126112945.1389573-1-naresh.solanki@9elements.com> <20240126-fleshed-subdued-36bae813e2ba@spud>
In-Reply-To: <20240126-fleshed-subdued-36bae813e2ba@spud>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 14 Feb 2024 14:50:18 +0530
Message-ID: <CABqG17injFdVVVYvbhqJNCpvBXeCKvA8OtJ+nx-0VNEi+NB=Hg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: hwmon: tda38640: Add interrupt & regulator properties
To: Conor Dooley <conor@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	mazziesaccount@gmail.com, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,


On Fri, 26 Jan 2024 at 21:54, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Jan 26, 2024 at 04:59:44PM +0530, Naresh Solanki wrote:
> > Add properties for interrupt & regulator.
> > Also update example.
>
> Feeling like a broken record, given I am leaving the same comments on
> multiple patches. The commit message needs to explain why you're doing
> something. I can read the diff and see what you did!
>
> >
> > TEST=Run below command & make sure there is no error.
> > make DT_CHECKER_FLAGS=-m dt_binding_check
>
> Same comment here as elsewhere.
Ack
>
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  .../hwmon/pmbus/infineon,tda38640.yaml        | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> > index ded1c115764b..2df625a8b514 100644
> > --- a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> > @@ -30,6 +30,15 @@ properties:
> >        unconnected(has internal pull-down).
> >      type: boolean
> >
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  regulators:
> > +    $ref: /schemas/regulator/regulator.yaml#
> > +    type: object
> > +    description: |
>
> The | here is not needed, there's no formatting to preserve.
Ack
>
> From a quick check, most bindings with regulator subnodes restrict the
> subnode names with patternproperties. Is there a reason you have not?
I have corrected it now & will push in next revision.
regulators is expected to have subnode vout0. like below:
  regulators:
    type: object
    description:
      list of regulators provided by this controller.

    properties:
      vout0:
        $ref: /schemas/regulator/regulator.yaml#
        type: object

        unevaluatedProperties: false

    additionalProperties: false


>
> > +      list of regulators provided by this controller.
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -38,6 +47,7 @@ additionalProperties: false
> >
> >  examples:
> >    - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> >      i2c {
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> > @@ -45,5 +55,15 @@ examples:
> >          tda38640@40 {
> >              compatible = "infineon,tda38640";
> >              reg = <0x40>;
> > +
> > +            //interrupt-parent = <&smb_pex_cpu0_event>;
>
> Why is this commented out? Please either restore it or remove it (with
> justification).
Ack. will restore it.
>
> Thanks
>
> Conor.
>
> > +            interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
>
> Blank line here please.
Ack

Regards,
Naresh
>
> > +            regulators {
> > +                pvnn_main_cpu0: vout0 {
> > +                    regulator-compatible = "vout0";
> > +                    regulator-name = "pvnn_main_cpu0";
> > +                    regulator-enable-ramp-delay = <200>;
> > +                };
> > +            };
> >          };
> >      };
> >
> > base-commit: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
> > --
> > 2.42.0
> >

