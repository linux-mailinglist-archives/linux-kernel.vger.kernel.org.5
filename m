Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7777A3F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 04:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjIRCBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 22:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjIRCBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 22:01:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04E97;
        Sun, 17 Sep 2023 19:01:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC020C433C8;
        Mon, 18 Sep 2023 02:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695002459;
        bh=P5kbmZu6oeMbM/PnhQwtSFCxSpJ/ktMepMBX4j4Jido=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=HUAbS/TCe7nPwq9iMY0e26ipjFoUiBffiD5fT7l2g3TaWQyMdO6TQtwxPrAL8OAyA
         tOx6KNswGmyoE1K3q4YUgvR/3c1Maio31BPI5X+1KK6j02difk4fccVLavTCwm7O8v
         VcwoQnPM1mbeLHUxZUmguNzib4JS8g9ky5cgwrcOL5tYfEo6buOuPJ8tvmkjwrLhgH
         f8OeEJfCCkwVsiSuHfZC3wWCcIWzkheG+zFPJ941VYLeKvHmvZhECqiX+rjG21HYbe
         asL6UhTSv7j2kSuOq8eAeFq+yXT2tqyWWUCBfECV951LtP9WzNMdeAvPSkMTbnTPnK
         zl3YvI+dQttEg==
Date:   Sun, 17 Sep 2023 19:00:58 -0700
From:   Kees Cook <kees@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, Kees Cook <keescook@chromium.org>,
        Ilya Dryomov <idryomov@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
User-Agent: K-9 Mail for Android
In-Reply-To: <3c4c7ca8-e1a2-fbb1-bda4-b7000eb9a8d9@redhat.com>
References: <20230915201510.never.365-kees@kernel.org> <3c4c7ca8-e1a2-fbb1-bda4-b7000eb9a8d9@redhat.com>
Message-ID: <6122C479-ADD9-43A8-8EB6-CF518F97F64C@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 17, 2023 5:25:10 PM PDT, Xiubo Li <xiubli@redhat=2Ecom> wrote:
>
>On 9/16/23 04:15, Kees Cook wrote:
> > [=2E=2E=2E]
>> Additionally, since the element count member must be set before accessi=
ng
>> the annotated flexible array member, move its initialization earlier=2E
>>=20
>> [=2E=2E=2E]
>> diff --git a/net/ceph/mon_client=2Ec b/net/ceph/mon_client=2Ec
>> index faabad6603db=2E=2Ef263f7e91a21 100644
>> --- a/net/ceph/mon_client=2Ec
>> +++ b/net/ceph/mon_client=2Ec
>> @@ -1136,6 +1136,7 @@ static int build_initial_monmap(struct ceph_mon_c=
lient *monc)
>>   			       GFP_KERNEL);
>>   	if (!monc->monmap)
>>   		return -ENOMEM;
>> +	monc->monmap->num_mon =3D num_mon;
>>     	for (i =3D 0; i < num_mon; i++) {
>>   		struct ceph_entity_inst *inst =3D &monc->monmap->mon_inst[i];
>> @@ -1147,7 +1148,6 @@ static int build_initial_monmap(struct ceph_mon_c=
lient *monc)
>>   		inst->name=2Etype =3D CEPH_ENTITY_TYPE_MON;
>>   		inst->name=2Enum =3D cpu_to_le64(i);
>>   	}
>> -	monc->monmap->num_mon =3D num_mon;
>
>BTW, is this change related ?

Yes, this is needed so that the __counted_by size is set before accessing =
the flexible array=2E

>
>>   	return 0;
>>   }
>>  =20
>
>Else LGTM=2E
>
>Reviewed-by: Xiubo Li <xiubli@redhat=2Ecom>

Thanks!


--=20
Kees Cook
