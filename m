Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83AA79CC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjILJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjILJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:41:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C31116;
        Tue, 12 Sep 2023 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5mkwbqFuSv2hlymMhsu3M4LU2jbDB6uW9iOmS/v2SLU=;
        t=1694511704; x=1695721304; b=dw9LonpqydlrvLX+NQBVuZTGcNDQ6vZ5DNMUT076QD6jZ2b
        WHDL74jp/vgEv1St7hXgm47ASW2NIce4DlwWD3UHOD7TfGghpaHiZ3OSuO0WxD3uKFSMx6Q25hcsx
        2v7GzsJ+q/MrBTDsQczSnvRFhSHwjh7/vtzwl+OHTfXpyKgoHY8owthuVBiSEBpla3tGvfT5ewEbb
        j7Xd9g6yIHaiZ2kAnkDxr7ismPLPC6e2LrTmvzxGaEiKK3unfuZLHHW2vfY/D9u4jZxS0I0XhAFT/
        CKwUPouyNubRHrfaPNUc0iOEmC3oGlKD93COlLrOP1uJj9KpMRCejENY/DOJWGJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qfztl-00CXmL-1Z;
        Tue, 12 Sep 2023 11:41:33 +0200
Message-ID: <c44b748307a074d0c250002cdcfe209b8cce93c9.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/8] scripts/gdb/symbols: add specific ko module load
 command
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chinwen.chang@mediatek.com, qun-wei.lin@mediatek.com,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        casper.li@mediatek.com, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Date:   Tue, 12 Sep 2023 11:41:29 +0200
In-Reply-To: <20230808083020.22254-2-Kuan-Ying.Lee@mediatek.com>
References: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
         <20230808083020.22254-2-Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-08 at 16:30 +0800, Kuan-Ying Lee wrote:
> Add lx-symbols <ko_path> command to support add specific
> ko module.

I'm not sure how this was supposed to work? It should have updated the
documentation, but more importantly, it shouldn't have broken the
documented usage of this command:

      The kernel (vmlinux) is taken from the current working directly. Modu=
les (.ko)
      are scanned recursively, starting in the same directory. Optionally, =
the module
      search path can be extended by a space separated list of paths passed=
 to the
      lx-symbols command.

Note how that talks about a "space separated list of paths" for which
clearly a single path seems like it should be accepted?

> @@ -138,6 +139,19 @@ lx-symbols command."""
>          else:
>              gdb.write("no module object found for '{0}'\n".format(module=
_name))
> =20
> +    def load_ko_symbols(self, mod_path):
> +        self.loaded_modules =3D []
> +        module_list =3D modules.module_list()
> +
> +        for module in module_list:
> +            module_name =3D module['name'].string()
> +            module_pattern =3D ".*/{0}\.ko(?:.debug)?$".format(
> +                module_name.replace("_", r"[_\-]"))
> +            if re.match(module_pattern, mod_path) and os.path.exists(mod=
_path):
> +                self.load_module_symbols(module, mod_path)
> +                return
> +        raise gdb.GdbError("%s is not a valid .ko\n" % mod_path)
> +
>      def load_all_symbols(self):
>          gdb.write("loading vmlinux\n")
> =20
> @@ -176,6 +190,11 @@ lx-symbols command."""
>          self.module_files =3D []
>          self.module_files_updated =3D False
> =20
> +        argv =3D gdb.string_to_argv(arg)
> +        if len(argv) =3D=3D 1:
> +            self.load_ko_symbols(argv[0])
> +            return

But this obviously breaks it, since passing a single path will go into
the if, then complain "some/folder/ is not a valid .ko" and exit.


But I'm not even sure how you intended this to work _at all_, because in
the context before this if, we have:

         self.module_paths =3D [os.path.abspath(os.path.expanduser(p))
                              for p in arg.split()]
         self.module_paths.append(os.getcwd())

so you first add the (file!) to the list of paths, and then try to load
the file by finding modules in the paths, and filtering by the specified
file? That seems ... very roundabout, and can even only work if the file
can be found via os.getcwd(), so you could never specify an absolute
filename?

All that seems counter to what the patch was meant to do.

I suspect that really you need to individually check "is it a file or a
directory" before handling any of this, and if it's actually a file,
don't use it as a _filter_ as you do in load_ko_symbols() now but
directly use it as is with load_module_symbols()?


@Jan, can we revert this? I came up with the following trivial fix that
makes it at least not break the original use case of passing a single-
entry directory list, but it really doesn't seem right one way or the
other.


--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -191,7 +191,7 @@ lx-symbols command."""
         self.module_files_updated =3D False
=20
         argv =3D gdb.string_to_argv(arg)
-        if len(argv) =3D=3D 1:
+        if len(argv) =3D=3D 1 and os.path.isfile(argv[0]):
             self.load_ko_symbols(argv[0])
             return
=20


johannes
