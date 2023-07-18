Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E049757B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjGRMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGRMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:17:13 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC53DE52;
        Tue, 18 Jul 2023 05:17:10 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id A8EAE588E7A03; Tue, 18 Jul 2023 14:17:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id A716C60E5C62D;
        Tue, 18 Jul 2023 14:17:08 +0200 (CEST)
Date:   Tue, 18 Jul 2023 14:17:08 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v4 4/4] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
In-Reply-To: <20230718102958.GW9196@kitsune.suse.cz>
Message-ID: <pq42o77-73np-66r-rrn9-ns24o907n59@vanv.qr>
References: <20230711153126.28876-1-msuchanek@suse.de> <cover.1689589902.git.msuchanek@suse.de> <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de> <76o21q7n-8qo8-37p6-oqno-q08nqpos471@vanv.qr> <20230718084300.GU9196@kitsune.suse.cz>
 <81n281ns-s8on-rsrn-pp61-q28pn42ns531@vanv.qr> <20230718102958.GW9196@kitsune.suse.cz>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 2023-07-18 12:29, Michal Suchánek wrote:
>> -static const char *dirname_default_prefix = MODULE_DIRECTORY;
>> +const char *dirname_default_prefix = MODULE_DIRECTORY;
>>  
>> @@ -2943,6 +2944,9 @@ static int do_depmod(int argc, char *argv[])
>>  				free(out_root);
>>  			out_root = path_make_absolute_cwd(optarg);
>>  			break;
>> +		case 'M':
>> +			dirname_default_prefix = optarg;
>> +			break;
>>  		case 'C': {
>>  			size_t bytes = sizeof(char *) * (n_config_paths + 2);
>>  			void *tmp = realloc(config_paths, bytes);
>
>That breaks kmod for the usrmerged distributions, though.

Does it though?
The *distro* has /lib -> /usr/lib,
the *staging area* for installation does not.

>[...]
>Note: it will work either way at the times the module directory can be
>accessed through the lib -> usr/lib compatibility symlink. The default
>needs to be correct for the cases when the symlink is not provided.

>So you could do
>
>make DEPMOD='depmod -M /lib/modules'

That would be a workable situation.
