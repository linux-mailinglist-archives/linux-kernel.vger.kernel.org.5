Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BEE7743F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjHHSOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjHHSNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2A1DF30
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691515072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Z37MNTsz5IjK+Ues18YoNQH3NZHekHYWw9QPHdtWSg=;
        b=eGhROQQpNDgQNuxZ5AZnTHd1Z/CJgNI9U/N85nPhaEs7280Fqe7vUPEwrZrn9rTEklEvYL
        n+cjQz6+ADR2GOwrTpNoPF4xZM/UE4c/jGWshHv2lUilwZios5aW/caqiamyHyfB/N+OWy
        ynsUbFd4Wjy6Nvc2NQ2myJWjrFrhzPE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-kP707D83MT6s30yJcG5OEA-1; Tue, 08 Aug 2023 01:11:29 -0400
X-MC-Unique: kP707D83MT6s30yJcG5OEA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bb98659f3cso35860245ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 22:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691471488; x=1692076288;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z37MNTsz5IjK+Ues18YoNQH3NZHekHYWw9QPHdtWSg=;
        b=GEbVZQ9bfHPZM6cTgZLR9WWSyaVJYC32CYdW9iPnhx/SxXrzDG1eOKKqMIlhlDhso9
         qxtEmAJGOoTlHL0fZw2IJegwuJtMf0+R/VqLFoz7jAEgLPXzQ7+nzumz5H4LqaqZl7Sr
         27XX7dFCPXMF78v2//kIFFY+FAe6eG1c+gsl6obSGk1s6noRf9UVYckyzpv4pJd7SN/o
         1DvKOkNUtCV3De9519FosdgDhoZu1jSe1FpN+RNc8Xi31k4Qc8keJTMvl/xJ8zWtIOev
         POF7XMh7MQuojK7/G6BGKMjhXwTxOyxAS3erHU1kuKVfcYjp2By+FMJayL9sDrg2g5JU
         a8Rg==
X-Gm-Message-State: AOJu0Yx7zbs/TDff84MHI5cHbtgwszVhbD/38tvLAHCa6hP6nbCPq+O5
        xQhEwi+FA9TwaoyHBZFuvZgUnXFagk5jBxjrMwm2KNsbm4mWJtxWpR9+JV2Sgk58d3kv7XKfVgr
        74R16fm1m2jnUeCgVRSOtzqhY
X-Received: by 2002:a17:902:6909:b0:1b8:9002:c9ee with SMTP id j9-20020a170902690900b001b89002c9eemr7750389plk.1.1691471488318;
        Mon, 07 Aug 2023 22:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ4mG8T42Oe8e4gGSTRDKxIeHrCvX8GrAvrWD26t+TaJGCnz1ILtcBVualyF31Wh+2WzFmOw==
X-Received: by 2002:a17:902:6909:b0:1b8:9002:c9ee with SMTP id j9-20020a170902690900b001b89002c9eemr7750382plk.1.1691471487992;
        Mon, 07 Aug 2023 22:11:27 -0700 (PDT)
Received: from smtpclient.apple ([115.96.156.158])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902eb4b00b001b9cea4e8a2sm7834747pli.293.2023.08.07.22.11.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2023 22:11:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
Date:   Tue, 8 Aug 2023 10:41:21 +0530
Cc:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4142F3A4-8AB4-4DE2-8D03-D3A8F8776BF9@redhat.com>
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
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Ping once more =E2=80=A6
Can anyone comment on the avove and/or review the patchset?

