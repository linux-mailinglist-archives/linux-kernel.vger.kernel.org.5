Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AFE80C3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjLKI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64225D9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702285025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5LTIUKaVC1eazTIk2UXuAlOz9lK8/aeDlO+nHP2T/TQ=;
        b=MUR6rhpAjRggdqy5w8t7/cJeAQiry/8ODTVRXM4+b4exeY5Ds6lgkSWZ/D7Xa+GCAGWC9J
        mthXopepeYlwF8xLaQMWqp/o2s23BGPWpS9Mq6l5oez/B9lxtjWYXWhfFkqCxTOgSDTkWN
        1C3Z53K6wFV3YLoQBzY7Wn7rGnw6fPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-g75ZPCryOzygFUl7RqAJLw-1; Mon, 11 Dec 2023 03:57:03 -0500
X-MC-Unique: g75ZPCryOzygFUl7RqAJLw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332ee20a40fso3552612f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285022; x=1702889822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LTIUKaVC1eazTIk2UXuAlOz9lK8/aeDlO+nHP2T/TQ=;
        b=ibgO1Lfs2ThL8zG+rsHOUdNw5eyVJt2BdPwpCxrj8VhNh2dwhpyKnHFFjFeocAk4FG
         hzLH+SsqNN4z2w3Zs5duh/kYcZ9Vf/rmZ98MzFzTk9QqA3F/jI6YKv1WpXOmfvAe9f3y
         hthIbHP211BwPJV8Kbb2YBbctLpH86OcyPqhc2E89NaliDudRVQ59ed5s3CFG3pptcvk
         nfMRLH1LsReezD7rimvfKhEX0s3HHlg2zpSqZk+xK+kVrs1y99RqVGXflFDtW9NAZXZS
         PS9MQhWl1CVzrF/hE5k47CI49SU0nP4NWxFeQsHOWfGdvq61MZPnKQLEWqlYqFeREhcn
         YTrg==
X-Gm-Message-State: AOJu0YwYaVXLIO5JnCFx/Gw7SAQsTX6F32ok8zx0+jFyGM1ya/K4I0vB
        uITqzP4LDc8DjXRMqerwMsvp77Y/PfFc/52GENjmXJ3w4UtbI944HfaJRoZhwmU4acQxxWkx9ax
        oiqlbE1AtF3AweiM4HyOKv/FV
X-Received: by 2002:a5d:4e04:0:b0:333:5448:a524 with SMTP id p4-20020a5d4e04000000b003335448a524mr1817797wrt.70.1702285022058;
        Mon, 11 Dec 2023 00:57:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsh9Yv6nd25XsjfPOninxctIiTaXU4lHFkIdNF81q3d42Ndazl+E7oJqr0sqZiOlOLBOy/Qw==
X-Received: by 2002:a5d:4e04:0:b0:333:5448:a524 with SMTP id p4-20020a5d4e04000000b003335448a524mr1817786wrt.70.1702285021772;
        Mon, 11 Dec 2023 00:57:01 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id k15-20020adfb34f000000b003334a1e92dasm8142312wrd.70.2023.12.11.00.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:57:01 -0800 (PST)
Date:   Mon, 11 Dec 2023 09:57:01 +0100
From:   Maxime Ripard <mripard@redhat.com>
To:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vigneshr@ti.com, tjoseph@cadence.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        danishanwar@ti.com, srk@ti.com, nm@ti.com
Subject: Re: [PATCH v13 0/5] PCI: add 4x lane support for pci-j721e
 controllers
Message-ID: <isttx4vp7warwowlz46oo7y2zex7xuizfvovfse3yb4ww72e6u@nuev2jbkhnhw>
References: <20231128054402.2155183-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hiyobel5xvyda7mp"
Content-Disposition: inline
In-Reply-To: <20231128054402.2155183-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hiyobel5xvyda7mp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bjorn, Krzysztof, Lorenzo, Rob,

On Tue, Nov 28, 2023 at 11:13:57AM +0530, Siddharth Vadapalli wrote:
> This series adds support to the pci-j721e PCIe controller for up to 4x La=
ne
> configuration supported by TI's J784S4 SoC. Bindings are also added for
> the num-lanes property which shall be used by the driver. The compatible
> for J784S4 SoC is added.
>=20
> This series is based on linux-next tagged next-20231128.

These patches have been floating around for a long time (v12 was almost
identical and was submitted back in April, without any review back then
already [1]), and it looks like reviewers are happy with it.

Could you merge them to get them in 6.8?

Thanks!
Maxime

1: https://lore.kernel.org/lkml/20230401112633.2406604-1-a-verma1@ti.com/

--hiyobel5xvyda7mp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXbO0AAKCRDj7w1vZxhR
xSCJAQCMVu4ns7BPOUOOt9ZXTqgjvASN082LC9xcB5COxIfLsQEArbDg/9j4+RST
/VDJ4u2ctcM4T8k/v3JMo23lk/ShmAA=
=8qsX
-----END PGP SIGNATURE-----

--hiyobel5xvyda7mp--

