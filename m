Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB80772818
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjHGOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjHGOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5337C10F8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC31361B4B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F1BC433C7;
        Mon,  7 Aug 2023 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691419510;
        bh=WSFD2bQVy6auzw96zhXrwKZKxc5XrsGkGJntb9ZP/4c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=YQ2NHZ709ZPBfz767TYgsEfLBlbLGDdaUOcyZ+w4lteLGcMIynJ28+Q9pBzZ4QMou
         +P9BhMUpAv9wQsEWfUIEUVGA9L8UX4KV1VLayQ0+Ciic7/2vMxXkSc0hajVi0FPTDz
         n5hfXyaPToTKBhKzf/7/ZX9pCIu+Y0ONe3hVr7OFbZ+9dJdNdZQkmji3v/w0oPtNf8
         730acCFilftvcDLViWK0aKMel9T4/q5OsW1XIJCG442nRaNOpjiZgTisytHRAocf4N
         9E4TEOdghjBSC11/J7ayXmol8XoPB5bpnzugn6NqiV9jftvoj92KBT2jBEAgRgGMSI
         jPCI0EpQ3T9vQ==
Date:   Mon, 07 Aug 2023 07:45:08 -0700
From:   Kees Cook <kees@kernel.org>
To:     =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
CC:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: binfmt_misc & different PE binaries
User-Agent: K-9 Mail for Android
In-Reply-To: <20230806162346.v7gjoev2nepxlcox@pali>
References: <20230706115550.sqyh3k26e2glz2lu@pali> <20230806162346.v7gjoev2nepxlcox@pali>
Message-ID: <C636CC6D-9504-4B81-8B47-2734C70F20C2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 6, 2023 9:23:46 AM PDT, "Pali Roh=C3=A1r" <pali@kernel=2Eorg> wro=
te:
>Hello, I would like to remind this email about binfmt_misc for PE=2E
>
>On Thursday 06 July 2023 13:55:50 Pali Roh=C3=A1r wrote:
>> Hello,
>>=20
>> I would like to ask how to properly register binfmt_misc for different
>> PE binaries, so kernel could execute the correct loader for them=2E
>>=20
>> I mean, how to register support for Win32 (console/gui) PE binaries and
>> also for CLR PE binaries (dotnet)=2E Win32 needs to be executed under w=
ine
>> and CLR ideally under dotnet core (or mono)=2E
>>=20
>> I have read kernel documentation files admin-guide/binfmt-misc=2Erst
>> and admin-guide/mono=2Erst=2E But seems that they are in conflicts as b=
oth
>> wants to registers its own handler for the same magic:
>>=20
>>   echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > register
>>=20
>>   echo ':CLR:M::MZ::/usr/bin/mono:' > /proc/sys/fs/binfmt_misc/register
>>=20
>> Not mentioning the fact that they register DOS MZ handler, which matche=
s
>> not only all PE binaries (including EFI, libraries, other processors),
>> but also all kind of other NE/LE/LX binaries and different DOS extender=
s=2E
>>=20
>> From documentation it looks like that even registering PE binaries is
>> impossible by binfmt_misc as PE is detected by checking that indirect
>> reference from 0x3C is PE\0\0=2E And distinguish between Win32 and CLR
>> needs to parse PE COM descriptor directory=2E
>>=20
>> Or it is possible to write binfmt_misc pattern match based on indirect
>> offset?

Normally a single userspace program will be registered and it can do whate=
ver it needs to do to further distinguish the binary and hand it off to the=
 appropriate loader=2E



--=20
Kees Cook
