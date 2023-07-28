Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CCC766A73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjG1K1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjG1K0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4E49E8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690539871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxPULaxNBfrPp7VpRK422Tk4/ctS+Y4M7guAF17ROmw=;
        b=HTtGu4YsuvpZzrbXp9JJ81gd9H5vpWgDeoURg/AL/fyH1Q+P+v0y4qn1ABjfqe+L4T/6Qf
        U7J513qgLkvRo6y+cDdOIc7YEkUwaLMDo0fLAbu7/mGPm30baLO6cEzHHufIplkaP8RcPG
        lnAwPGQnWDjNq5IbxKbyzcTMVaqenJM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-kYXkfw72Phy-IbqCsUJ_ZA-1; Fri, 28 Jul 2023 06:24:30 -0400
X-MC-Unique: kYXkfw72Phy-IbqCsUJ_ZA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe108cbed6so1788872e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539869; x=1691144669;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxPULaxNBfrPp7VpRK422Tk4/ctS+Y4M7guAF17ROmw=;
        b=cYqKUmmPxuWalV55KXpYo63p7Cc7xVDDw6jsAgzsvOlSdS93cU3yVn9M6Yp56Tbwh1
         due1v34BF7iICXre/pGshZj6N/mhCbw5EkyFSBQWeORA1hooU1rFCG6AUYAYCfaqsBeI
         YdxR9cG/SGuVeeDyWTkmZBItRIB7HpnY8ZmlnkQOlKzQ2V1iyVWRtR2Aw5ZndYM2PWog
         /Fo7OKZe7ZAWrkbjzTnXoRL6QBa10Cth3VNIlv60yuwhxzhzJNXgP7WuXmT8QuUOKD7e
         hA8BWsyUyICmj38musLfT4cQ6/nfePwqFkKml75LjKEUMODC8yvVExYtCpVF7WP5fgFl
         MtfA==
X-Gm-Message-State: ABy/qLZWqHL83ZfHInyhP0usN4j0DR2sZt4ThrQPOxcnFHssvi/LgIvV
        MCI1PmGShITisf4MZuF/kxCljGcvEI5rJMmHHLHibMGcCRBVsGJ6ILqBS4EiabtdR9Zbpr3uZup
        9EiIHNJkh9CWJ7eZlcS0+zcTZ
X-Received: by 2002:ac2:5e79:0:b0:4f8:46e9:9f19 with SMTP id a25-20020ac25e79000000b004f846e99f19mr1381481lfr.1.1690539869067;
        Fri, 28 Jul 2023 03:24:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFHzWYA1OBlcAOqdfrcdIzqWL6Su/1ncGYESOGE8AnmZFxXOlPXYXtLZekFEHB6YWzVzJvrxg==
X-Received: by 2002:ac2:5e79:0:b0:4f8:46e9:9f19 with SMTP id a25-20020ac25e79000000b004f846e99f19mr1381463lfr.1.1690539868732;
        Fri, 28 Jul 2023 03:24:28 -0700 (PDT)
Received: from smtpclient.apple ([115.96.134.213])
        by smtp.gmail.com with ESMTPSA id y18-20020a1c4b12000000b003fbd597bccesm6548258wma.41.2023.07.28.03.24.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:24:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
Date:   Fri, 28 Jul 2023 15:54:18 +0530
Cc:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0013CBFD-327E-4849-B7AF-749A027D7744@redhat.com>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
 <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 12-Jul-2023, at 12:32 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 23-May-2023, at 11:06 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>=20
>> On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
>>> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
>>>> Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
>>>>=20
>>>>> Olaf, is this a reviewed-by from you? :-)
>>>>=20
>>>> Sorry, I did not review the new functionality, just tried to make =
sure there will be no regression for existing consumers.
>>>=20
>>> Okay, this is fine, too. Thank you for looking into this.
>>>=20
>>>=20
>>>>=20
>>>> Olaf
>>>=20
>>=20
>> Gentle reminder.
>>=20
>=20
> I have a comment about the following change:
>=20
> +		error =3D fprintf(nmfile, "\n[ipv4]\n");
> +		if (error < 0)
> +			goto setval_error;
> +
> +		if (new_val->dhcp_enabled) {
> +			error =3D kvp_write_file(nmfile, "method", "", =
"auto");
> +			if (error < 0)
> +				goto setval_error;
> +		} else {
> +			error =3D kvp_write_file(nmfile, "method", "", =
"manual");
> +			if (error < 0)
> +				goto setval_error;
> +		}
>=20
> I think the method equally would apply for ipv6 as it applies for =
ipv4.=20
> We can use =
https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel=
/#18_Disable_IPv6_Address_for_ethernet_connection_IPV6INIT as a =
reference.=20
> So setting the method should be common to both ipv4 and ipv6.

Ping =E2=80=A6=20

