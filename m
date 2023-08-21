Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640557823DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjHUGqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHUGq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA7AC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692600341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUH8EM/c4BgCyJddNU6uELLJ8bA/pGDspC2Nb/HHUYY=;
        b=jC6II0PDu6LOwaf0BX6sQkJxAnR5aeGN12DFhcbiwhFUzpDYxcefgK3SLZaxDxc9muKTwr
        v/HzlLa7QbDFsYbaC1W87rWNLrSn/oUlBJKiAu6teZ2bASvSndSXNMLvT058ktJ1d4PMUR
        WvVk2PhQTEIFSErDd9WbaLY9qNY5+PM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-8iYlv8DTPQeMEuKjhgGRig-1; Mon, 21 Aug 2023 02:45:38 -0400
X-MC-Unique: 8iYlv8DTPQeMEuKjhgGRig-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-26f3fce5b0bso1051672a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692600337; x=1693205137;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUH8EM/c4BgCyJddNU6uELLJ8bA/pGDspC2Nb/HHUYY=;
        b=aZXUBeK+SNFX7rQ+Rf5TVL6nzjFMEp96t9tdzO16L3HelmLsnn32QzWdkSr+QtM3Cd
         iUBRC+8mAF8xnpGcJiICvVfU6v4NIhJHO5Y0b5xcbyMI9Nf7Oi99Ken/ZbQLbxP1g1JB
         wmy77x3rZLqhB1NZPkk3Rl9A1b2IOBB42LL0IYmfdBojjMPkQsmU7y8u6SoJN1bn3bJI
         JSAYQapE/Jbkd+s982J+qgRDYYUTiuz6BH8dXLyc856C/F4jj38dLIP0fFftqKFy5RG6
         uwrUEX9EliGMxGBKHJyCjw/qomforobB1koPTWfcPajYv/ma8Nvdlke3Iml3ikzRBt3b
         ws7A==
X-Gm-Message-State: AOJu0YxaqQ2dPiTi0/4gblirGygQhVwoP9ORN2jXIerPR8P+rWwrND/B
        93rhTiRqBlyYxMQgCpFCWlebVJaHYklRZD7V7HhUZnkbvHqailUNfIJsMeY1+mzd99Nxj5aCGR9
        Ggbk6nw6XJt5/aTSTtH5AOfDw
X-Received: by 2002:a17:90a:2f06:b0:268:37b:a10e with SMTP id s6-20020a17090a2f0600b00268037ba10emr2885282pjd.11.1692600337173;
        Sun, 20 Aug 2023 23:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhMxnaElq+qOTcktFtonqQ5m9DNcuZEtAl/95cxPPiE918/oL2gA20Hrfq336KSnmg4f84nA==
X-Received: by 2002:a17:90a:2f06:b0:268:37b:a10e with SMTP id s6-20020a17090a2f0600b00268037ba10emr2885246pjd.11.1692600336873;
        Sun, 20 Aug 2023 23:45:36 -0700 (PDT)
Received: from smtpclient.apple ([49.207.201.27])
        by smtp.gmail.com with ESMTPSA id d19-20020a17090ae29300b00267eead2f16sm5376430pjz.36.2023.08.20.23.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2023 23:45:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230808054248.GA12620@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date:   Mon, 21 Aug 2023 12:15:29 +0530
Cc:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A8AA269-FBDB-4023-9809-273C046B2BCD@redhat.com>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
 <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
 <4142F3A4-8AB4-4DE2-8D03-D3A8F8776BF9@redhat.com>
 <20230808054248.GA12620@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 08-Aug-2023, at 11:12 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> On Tue, Aug 08, 2023 at 10:41:21AM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 12-Jul-2023, at 12:32 PM, Ani Sinha <anisinha@redhat.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 23-May-2023, at 11:06 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>>>=20
>>>> On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
>>>>> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
>>>>>> Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
>>>>>>=20
>>>>>>> Olaf, is this a reviewed-by from you? :-)
>>>>>>=20
>>>>>> Sorry, I did not review the new functionality, just tried to make =
sure there will be no regression for existing consumers.
>>>>>=20
>>>>> Okay, this is fine, too. Thank you for looking into this.
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>> Olaf
>>>>>=20
>>>>=20
>>>> Gentle reminder.
>>>>=20
>>>=20
>>> I have a comment about the following change:
>>>=20
>>> +		error =3D fprintf(nmfile, "\n[ipv4]\n");
>>> +		if (error < 0)
>>> +			goto setval_error;
>>> +
>>> +		if (new_val->dhcp_enabled) {
>>> +			error =3D kvp_write_file(nmfile, "method", "", =
"auto");
>>> +			if (error < 0)
>>> +				goto setval_error;
>>> +		} else {
>>> +			error =3D kvp_write_file(nmfile, "method", "", =
"manual");
>>> +			if (error < 0)
>>> +				goto setval_error;
>>> +		}
>>>=20
>>> I think the method equally would apply for ipv6 as it applies for =
ipv4.=20
>>> We can use =
https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel=
/#18_Disable_IPv6_Address_for_ethernet_connection_IPV6INIT as a =
reference.=20
>>> So setting the method should be common to both ipv4 and ipv6.
>>=20
>> Ping once more ???
>> Can anyone comment on the avove and/or review the patchset?
> That's correct Ani, this needs to be enabled for ipv6 as well, will =
send out another version. Thanks for catching this.

Have you sent out a new version? I do not see anything in my inbox.
>=20

