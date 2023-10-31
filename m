Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584277DD71B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJaUdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJaUdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:33:44 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7D1F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39VKXRM9762787
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 31 Oct 2023 13:33:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39VKXRM9762787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023101201; t=1698784410;
        bh=Hvkle5GQ+dtE2eXumoN/58pNx6VdHfIVp/amixRhIzk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=AGDy8tJm82myZ2rABOTRHQU9++npFJ/61lIltbNUtMiBOhF0/K+2Yf/T3amaS6rfy
         LMjshjjauoc3A34/aO/1BjacjGI3zGfhHOf5PYTmNzhz5qBQinbJisxCghAbW3xO6s
         uu7hZMxUfzJ9Lkb2xbTCA2TyO7QoINoVCiB2h1EmICrKKqD8daAI+zkuJe50paksnj
         gfvSdQ6/Wv72kUahG+CSMlt34cd+fAj51vKzBHuDOtJdfbJNrUhZ0OeCe1q/+LCFar
         se5DtyVSzaulVJM7Gez1tysShwwy5TyvPqCowtNwA/fUyC+/zxXX6X/n44LzqBPhHS
         cSFa4usG/e2Sg==
Date:   Tue, 31 Oct 2023 13:33:22 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Rob Landley <rob@landley.net>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
User-Agent: K-9 Mail for Android
In-Reply-To: <b035a00f-865a-453c-bb27-0916aada0594@linux.ibm.com>
References: <20231031154417.621742-1-stefanb@linux.ibm.com> <2023103159-punctuate-amount-f09d@gregkh> <b035a00f-865a-453c-bb27-0916aada0594@linux.ibm.com>
Message-ID: <3FBB731F-2A45-4EC6-AF8C-76C21B8607BC@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 31, 2023 10:11:01 AM PDT, Stefan Berger <stefanb@linux=2Eibm=2Ec=
om> wrote:
>
>On 10/31/23 12:56, Greg Kroah-Hartman wrote:
>> On Tue, Oct 31, 2023 at 11:44:17AM -0400, Stefan Berger wrote:
>>> rootfs currently does not use tmpfs if the root=3D boot option is pass=
ed
>>> even though the documentation about rootfs (added in 6e19eded3684) in
>>> Documentation/filesystems/ramfs-rootfs-initramfs=2Erst states:
>>>=20
>>>    If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs =
by
>>>    default=2E  To force ramfs, add "rootfstype=3Dramfs" to the kernel =
command
>>>    line=2E
>> At this point in time, is there even any difference between ramfs and
>> tmpfs anymore?  Why would you want to choose one over the other here?
>
>CONFIG_TPMFS_XATTRS allows us to set xattrs, such as security=2Eima=2E
>
>=C2=A0=C2=A0 Stefan
>
>>=20
>> thanks,
>>=20
>> greg k-h
Why do we even keep ramfs as a standalone file system? To guarantee it can=
not be swapped out? Does anyone actually use it?
