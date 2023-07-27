Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114417658F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjG0QkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjG0QkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E135B3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51C0A61ED4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64786C433C8;
        Thu, 27 Jul 2023 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690476005;
        bh=bO56ZHhEtSBEpQFJFvdRzz7TargHjGNdtwpZ8hrxcvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2GQ8qyOKThVAfheklwCml5Mng28LizrXQcJwGO0BAx4obL+D7kttr5eAuKi21weu
         gQGkJE2vZGz7JZiP0PI0UzbKfHY5j8nOklbdr271dE9VBwqcJdokhC3wcIAyGtxs2R
         XWuKPr7TsWaMPP1kny0JTBu7Xv/o/J2dt1hD7trkb2IzZ5BVjPfQJ/VurKA8v4hmpa
         hxsdNHpfpasFpEXxlp1Wv/ipauWzfH52vPk8222h8xar7ohRyTdYxZPuV53ylKSuhl
         OJpTWKuGxJERt5H6c77ImJLX0tUqZ1E+8CUCC+jjWj13YHREdSA0Oon5O1I8lPNNx3
         J9iInrszhtyeQ==
Date:   Thu, 27 Jul 2023 09:40:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Steven French <Steven.French@microsoft.com>
Cc:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] fs/smb/client/sess.c:160:5: warning: stack frame size
 (1152) exceeds limit (1024) in 'cifs_try_adding_channels'
Message-ID: <20230727164003.GA79803@dev-arch.thelio-3990X>
References: <202307270640.5ODmPwDl-lkp@intel.com>
 <DM4PR21MB34413441C9DF320C24F5A84FE401A@DM4PR21MB3441.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR21MB34413441C9DF320C24F5A84FE401A@DM4PR21MB3441.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, Jul 27, 2023 at 03:36:11AM +0000, Steven French wrote:
> Does anyone recognize the problem here - the stack size it is complaining about has a small stack usage not a large one
>      cifs_try_adding_channels   has five pointers and five ints on the stack.  That seems small - not large.  It is called by cifs_mount which doesn't seem too bad in its stack usage either.
> 
> Any ideas why the stack size complaint is made?

Unfortunately, it seems like a recent-ish LLVM change removed the handy
spill/variable information that would have shed a little more immediate
light on this situation:

https://github.com/ClangBuiltLinux/linux/issues/1894

Building with a version that has that reveals:

  fs/smb/client/sess.c:160:5: warning: stack frame size (1152) exceeds limit (1024) in 'cifs_try_adding_channels' [-Wframe-larger-than]
  int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
      ^
  412/1152 (35.76%) spills, 740/1152 (64.24%) variables
  1 warning generated.

The spills are definitely not great but it looks like there is a
moderately large stack variable in cifs_ses_add_channel(), which gets
inlined into cifs_try_adding_channels(). Unfortunately, pahole appears
to be borked for me but -Rpass-analysis=stack-frame-layout shows it:

  fs/smb/client/sess.c:161:1: remark:
  Function: cifs_try_adding_channels
  Offset: [SP-8], Type: Spill, Align: 8, Size: 8
  Offset: [SP-16], Type: Spill, Align: 8, Size: 8
  Offset: [SP-24], Type: Spill, Align: 8, Size: 8
  Offset: [SP-32], Type: Spill, Align: 8, Size: 8
  Offset: [SP-40], Type: Spill, Align: 8, Size: 8
  Offset: [SP-48], Type: Spill, Align: 8, Size: 8
  Offset: [SP-56], Type: Spill, Align: 8, Size: 8
  Offset: [SP-64], Type: Spill, Align: 8, Size: 8
  Offset: [SP-72], Type: Spill, Align: 8, Size: 8
  Offset: [SP-80], Type: Spill, Align: 8, Size: 8
  Offset: [SP-88], Type: Protector, Align: 8, Size: 8
  Offset: [SP-712], Type: Variable, Align: 8, Size: 624  <-- ctx, struct smb3_fs_context
  Offset: [SP-801], Type: Variable, Align: 1, Size: 89
  Offset: [SP-816], Type: Spill, Align: 8, Size: 8
  Offset: [SP-824], Type: Spill, Align: 8, Size: 8
  Offset: [SP-832], Type: Spill, Align: 8, Size: 8
  Offset: [SP-840], Type: Spill, Align: 8, Size: 8
  Offset: [SP-848], Type: Spill, Align: 8, Size: 8
  Offset: [SP-856], Type: Spill, Align: 8, Size: 8
  Offset: [SP-864], Type: Spill, Align: 8, Size: 8
  Offset: [SP-872], Type: Spill, Align: 8, Size: 8
  Offset: [SP-880], Type: Spill, Align: 8, Size: 8
  Offset: [SP-888], Type: Spill, Align: 8, Size: 8
  Offset: [SP-896], Type: Spill, Align: 8, Size: 8
  Offset: [SP-904], Type: Spill, Align: 8, Size: 8
  Offset: [SP-912], Type: Spill, Align: 8, Size: 8
  Offset: [SP-920], Type: Spill, Align: 8, Size: 8
  Offset: [SP-928], Type: Spill, Align: 8, Size: 8
  Offset: [SP-936], Type: Spill, Align: 8, Size: 8
  Offset: [SP-944], Type: Spill, Align: 8, Size: 8
  Offset: [SP-952], Type: Spill, Align: 8, Size: 8
  Offset: [SP-960], Type: Spill, Align: 8, Size: 8
  Offset: [SP-968], Type: Spill, Align: 8, Size: 8
  Offset: [SP-976], Type: Spill, Align: 8, Size: 8
  Offset: [SP-984], Type: Spill, Align: 8, Size: 8
  Offset: [SP-992], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1000], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1008], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1016], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1024], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1028], Type: Spill, Align: 4, Size: 4
  Offset: [SP-1040], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1048], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1056], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1064], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1072], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1080], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1088], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1096], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1104], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1112], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1120], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1124], Type: Spill, Align: 4, Size: 4
  Offset: [SP-1128], Type: Spill, Align: 4, Size: 4
  Offset: [SP-1136], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1144], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1152], Type: Spill, Align: 8, Size: 8 [-Rpass-analysis=stack-frame-layout]
    161 | {
        | ^

There is probably more we can do on the compiler side to improve the
spills but I suspect marking cifs_ses_add_channel() as
noinline_for_stack or switching ctx to a head allocation would resolve
this.

Cheers,
Nathan

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, July 26, 2023 5:44 PM
> To: Steven French <Steven.French@microsoft.com>
> Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] fs/smb/client/sess.c:160:5: warning: stack frame size (1152) exceeds limit (1024) in 'cifs_try_adding_channels'
> 
> Hi Steve,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0a8db05b571ad5b8d5c8774a004c0424260a90bd
> commit: 38c8a9a52082579090e34c033d439ed2cd1a462d smb: move client and server files to common directory fs/smb
> date:   9 weeks ago
> config: mips-loongson2k_defconfig (https://download.01.org/0day-ci/archive/20230727/202307270640.5ODmPwDl-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230727/202307270640.5ODmPwDl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore/
> | .kernel.org%2Foe-kbuild-all%2F202307270640.5ODmPwDl-lkp%40intel.com%2F
> | &data=05%7C01%7CSteven.French%40microsoft.com%7C2cc584fd937a4cd5b9d008
> | db8e29f75b%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63826008313023
> | 4737%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> | iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=AauGIxZRPM5DK1J5j6lyEp
> | jOkArxfVtIUAnmPcxcCQs%3D&reserved=0
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/smb/client/sess.c:160:5: warning: stack frame size (1152) exceeds
> >> limit (1024) in 'cifs_try_adding_channels' [-Wframe-larger-than]
>      160 | int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
>          |     ^
>    1 warning generated.
> 
> 
> vim +/cifs_try_adding_channels +160 fs/smb/client/sess.c
> 
> b54034a73baf9f fs/cifs/sess.c Shyam Prasad N  2022-01-03  158
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  159  /* returns number of channels added */ 387ec58f339b0c fs/cifs/sess.c Ronnie Sahlberg 2020-12-14 @160  int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses)
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  161  {
> 90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  162   struct TCP_Server_Info *server = ses->server;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  163   int old_chan_count, new_chan_count;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  164   int left;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  165   int rc = 0;
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  166   int tries = 0;
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  167   struct cifs_server_iface *iface = NULL, *niface = NULL;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  168
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  169   spin_lock(&ses->chan_lock);
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  170
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  171   new_chan_count = old_chan_count = ses->chan_count;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  172   left = ses->chan_max - ses->chan_count;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  173
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  174   if (left <= 0) {
> 88b024f556fcd5 fs/cifs/sess.c Shyam Prasad N  2021-11-19  175           spin_unlock(&ses->chan_lock);
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  176           cifs_dbg(FYI,
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  177                    "ses already at max_channels (%zu), nothing to open\n",
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  178                    ses->chan_max);
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  179           return 0;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  180   }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  181
> 90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  182   if (server->dialect < SMB30_PROT_ID) {
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  183           spin_unlock(&ses->chan_lock);
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  184           cifs_dbg(VFS, "multichannel is not supported on this protocol version, use 3.0 or above\n");
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  185           return 0;
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  186   }
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  187
> 90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  188   if (!(server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
> 9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  189           ses->chan_max = 1;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  190           spin_unlock(&ses->chan_lock);
> 90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  191           cifs_server_dbg(VFS, "no multichannel support\n");
> 9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  192           return 0;
> 9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  193   }
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  194   spin_unlock(&ses->chan_lock);
> 9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  195
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  196   /*
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  197    * Keep connecting to same, fastest, iface for all channels as
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  198    * long as its RSS. Try next fastest one if not RSS or channel
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  199    * creation fails.
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  200    */
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  201   spin_lock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  202   iface = list_first_entry(&ses->iface_list, struct cifs_server_iface,
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  203                            iface_head);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  204   spin_unlock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  205
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  206   while (left > 0) {
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  207
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  208           tries++;
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  209           if (tries > 3*ses->chan_max) {
> bbbf9eafbfdaa2 fs/cifs/sess.c Steve French    2020-05-30  210                   cifs_dbg(FYI, "too many channel open attempts (%d channels left to open)\n",
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  211                            left);
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  212                   break;
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  213           }
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  214
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  215           spin_lock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  216           if (!ses->iface_count) {
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  217                   spin_unlock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  218                   break;
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  219           }
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  220
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  221           list_for_each_entry_safe_from(iface, niface, &ses->iface_list,
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  222                               iface_head) {
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  223                   /* skip ifaces that are unusable */
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  224                   if (!iface->is_active ||
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  225                       (is_ses_using_iface(ses, iface) &&
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  226                        !iface->rss_capable)) {
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  227                           continue;
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  228                   }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  229
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  230                   /* take ref before unlock */
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  231                   kref_get(&iface->refcount);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  232
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  233                   spin_unlock(&ses->iface_lock);
> 387ec58f339b0c fs/cifs/sess.c Ronnie Sahlberg 2020-12-14  234                   rc = cifs_ses_add_channel(cifs_sb, ses, iface);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  235                   spin_lock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  236
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  237                   if (rc) {
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  238                           cifs_dbg(VFS, "failed to open extra channel on iface:%pIS rc=%d\n",
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  239                                    &iface->sockaddr,
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  240                                    rc);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  241                           kref_put(&iface->refcount, release_iface);
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  242                           continue;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  243                   }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  244
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  245                   cifs_dbg(FYI, "successfully opened new channel on iface:%pIS\n",
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  246                            &iface->sockaddr);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  247                   break;
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  248           }
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  249           spin_unlock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  250
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  251           left--;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  252           new_chan_count++;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  253   }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  254
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  255   return new_chan_count - old_chan_count;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  256  }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  257
> 
> :::::: The code at line 160 was first introduced by commit
> :::::: 387ec58f339b0c45e3767395f11fa8dd3772131e cifs: simplify handling of cifs_sb/ctx->local_nls
> 
> :::::: TO: Ronnie Sahlberg <lsahlber@redhat.com>
> :::::: CC: Steve French <stfrench@microsoft.com>
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
