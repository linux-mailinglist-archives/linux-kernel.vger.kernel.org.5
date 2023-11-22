Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA987F4BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbjKVP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbjKVP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:57:13 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BAED8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:57:09 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db048181cd3so6783033276.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700668628; x=1701273428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z0RK/SpWoz+kpe3t/H/b8d6AuI1LIxn2YVK3cS+5J4=;
        b=QYXSA0cTP7ijP9ftrekuu2bi6VOdETFjMYEd7juf2HG4O+aTdMp2lApRD3weEsIDIP
         ZbOA84VJirxkW4sf0kLqnlwgaYWNGnDwlKcVmmeCJtR2MR5brZk6dAb/yH1BDWQdv28c
         pt3vEnPZXIpVo0PyiROCY4Bx3XPSQvzhygyHBGEIQ7pXcMzhI1w23cbdB30hRdWDl4XV
         UNRY5zJmNLTLuqAp/X7S/RG+B4LZVjYNHEA6JYv3Jmj6qOoFoGYBVL/v5xcwBlD4kt/D
         9islFrA4Ju98u4PQTY8GDLVwYj9qAr8TnX6EBcfzDD2nIVMGOQYniGfCa4YrIqE5wxNZ
         RXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668628; x=1701273428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z0RK/SpWoz+kpe3t/H/b8d6AuI1LIxn2YVK3cS+5J4=;
        b=qcsvLZyShULMUsERsSM1AurQ6H9xWFOkB9Bzj+JYqnjgRukM6Nip4wkZeWmRXWG2xm
         H90l3dQhng/sQkjzRVG/9FbtvlMfZ8C4cu22Tl67K+haLfhwnY1Ft3BLM87LQsxfEHRe
         btuCdMLc9aMsyJrADHRo38OPJgS+F6fMXPQO+Qio15KJDxA84XUocgXD/AniKOx7N2LY
         Wi4N2DEj9gF3kvSp7fh3QEZOML8ByYep6wEAXlCc/j46fxDpUvUSbLaPAe5u+6wGwUXk
         9/c4Kryy3B/4HA4ivUoxE3FEwgL9Gzqw3CCj9yhXDZEOKq+zzm+oQHN+JInB2RYLqmMK
         /LIQ==
X-Gm-Message-State: AOJu0YyD4sXVw0JVNBUdx9GlMhGpiYIsIpEmJiirs1NzwyUqsopIONjJ
        vPrS8O7hUkncPIEmbB4ZOuLsgAA3UGm5tqzy2yTt
X-Google-Smtp-Source: AGHT+IE7Sq0ixk+Ro5+SCHHAYlwPM997OhYDeJ/ZdAr2Occ4QlfxYQNKuagMLO9THEFK5O2H3/C6jTykXeNuHGstJhw=
X-Received: by 2002:a25:7743:0:b0:d9a:d184:8304 with SMTP id
 s64-20020a257743000000b00d9ad1848304mr2600130ybc.35.1700668628217; Wed, 22
 Nov 2023 07:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20231122135242.2779058-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231122135242.2779058-1-Ilia.Gavrilov@infotecs.ru>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Nov 2023 10:56:57 -0500
Message-ID: <CAHC9VhTiq1xPXXsETNKRBOtfkB5wohVwhBeae+5QW9uV-h5vvg@mail.gmail.com>
Subject: Re: [PATCH net] calipso: Fix memory leak in netlbl_calipso_add_pass()
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Huw Davies <huw@codeweavers.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 8:55=E2=80=AFAM Gavrilov Ilia <Ilia.Gavrilov@infote=
cs.ru> wrote:
>
> If IPv6 support is disabled at boot (ipv6.disable=3D1),
> the calipso_init() -> netlbl_calipso_ops_register() function isn't called=
,
> and the netlbl_calipso_ops_get() function always returns NULL.
> In this case, the netlbl_calipso_add_pass() function allocates memory
> for the doi_def variable but doesn't free it with the calipso_doi_free().

It looks like a better option would be to return an error code in
netlbl_calipso_add() so we never allocate the memory in the first
place.

Untested patch below, copy-n-paste'd so there is likely whitespace
damage, but you get the idea.

diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calips=
o.c
index f1d5b8465217..26a504dc6e57 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -54,8 +54,31 @@ static const struct nla_policy
calipso_genl_policy[NLBL_CALIPSO_A_MAX + 1] =3D {
       [NLBL_CALIPSO_A_MTYPE] =3D { .type =3D NLA_U32 },
};

+static const struct netlbl_calipso_ops *calipso_ops;
+
+/**
+ * netlbl_calipso_ops_register - Register the CALIPSO operations
+ * @ops: ops to register
+ *
+ * Description:
+ * Register the CALIPSO packet engine operations.
+ *
+ */
+const struct netlbl_calipso_ops *
+netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
+{
+       return xchg(&calipso_ops, ops);
+}
+EXPORT_SYMBOL(netlbl_calipso_ops_register);
+
+static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
+{
+       return READ_ONCE(calipso_ops);
+}
+
/* NetLabel Command Handlers
 */
+
/**
 * netlbl_calipso_add_pass - Adds a CALIPSO pass DOI definition
 * @info: the Generic NETLINK info block
@@ -100,10 +123,13 @@ static int netlbl_calipso_add(struct sk_buff
*skb, struct genl_info *info)
{
       int ret_val =3D -EINVAL;
       struct netlbl_audit audit_info;
+       const struct netlbl_calipso_ops *ops =3D netlbl_calipso_ops_get();

       if (!info->attrs[NLBL_CALIPSO_A_DOI] ||
           !info->attrs[NLBL_CALIPSO_A_MTYPE])
               return -EINVAL;
+       if (!ops)
+               return -EOPNOTSUPP;

       netlbl_netlink_auditinfo(&audit_info);
       switch (nla_get_u32(info->attrs[NLBL_CALIPSO_A_MTYPE])) {
@@ -363,28 +389,6 @@ int __init netlbl_calipso_genl_init(void)
       return genl_register_family(&netlbl_calipso_gnl_family);
}

-static const struct netlbl_calipso_ops *calipso_ops;
-
-/**
- * netlbl_calipso_ops_register - Register the CALIPSO operations
- * @ops: ops to register
- *
- * Description:
- * Register the CALIPSO packet engine operations.
- *
- */
-const struct netlbl_calipso_ops *
-netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
-{
-       return xchg(&calipso_ops, ops);
-}
-EXPORT_SYMBOL(netlbl_calipso_ops_register);
-
-static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
-{
-       return READ_ONCE(calipso_ops);
-}
-
/**
 * calipso_doi_add - Add a new DOI to the CALIPSO protocol engine
 * @doi_def: the DOI structure

--=20
paul-moore.com
