Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB238025D9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjLCQ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:59:30 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D655BEA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 08:59:34 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E17A62800C8E4;
        Sun,  3 Dec 2023 17:59:32 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D426A1F5BD2; Sun,  3 Dec 2023 17:59:32 +0100 (CET)
Date:   Sun, 3 Dec 2023 17:59:32 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Carpenter <error27@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-sparse@vger.kernel.org
Subject: Re: drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast from
 restricted pci_channel_state_t
Message-ID: <20231203165932.GA6480@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/7ZzYyisv1ylrho@kadam>
 <Y/7YN7U9Q2iqNDFo@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FAKE_REPLY_C,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

0-day has sent out 5 more e-mails about this sparse warning in the last
2 days alone.  That prompted me to take a closer look...


On Wed, Mar 01, 2023 at 07:44:39AM +0300, Dan Carpenter wrote:
> On Tue, Feb 28, 2023 at 10:33:25PM +0100, Lukas Wunner wrote:
> I do smatch, not sparse.  Sparse maintainers are on
> linux-sparse@vger.kernel.org.

Right, sorry for the confusion.  Adding linux-sparse and Luc to cc.
Quoting previous conversation for context, my findings are further below:


> > 0-day is reporting sparse warnings introduced by commit 74ff8864cc84
> > ("PCI: hotplug: Allow marking devices as disconnected during
> > bind/unbind"), which landed in Linus' tree this week.
> > 
> > The warnings are caused by invocations of xchg() and cmpxchg()
> > on an enum type ("cast from restricted pci_channel_state_t").
> 
> pci_channel_state_t is not an enum.  The problem is the __bit_wise.
> 
> > 
> > It seems they are only reported for architectures whose arch_xchg()
> > and arch_cmpxchg() macros cast the argument to an unsigned long.
> > Archictures such as x86 don't do that, but a number of others do.
> > The 0-day report, reproduced below in full, is for loongarch.
> > 
> > I'm wondering why the cast is necessary at all.  Digging in the
> > git history, I noticed that it has existed at least on arm since
> > forever.  I suspect that its use on newer arches such as loongarch
> > may be due to cargo-culting.
> 
> Speaking as an absolutely newbie and ignoramous, I can't see any point
> to the cast in arch_xchg().  But I am also surprised that silences the
> warning.  I would have thought that removing the cast would change the
> warning from "warning: cast from restricted my_type_t" to
> "warning: incorrect type in argument 1 (different base types)".
> 
> > Please advise whether these sparse warnings are false positives which
> > can be ignored and if they aren't, how to resolve them.  If you happen
> > to know the rationale for the cast, I'd be grateful if you could shed
> > some light on it.  Thanks a lot!
> 
> The question is more why is pci_channel_state_t declared as __bit_wise.
> __bit_wise data can only be used through accessor functions, like user
> pointers have to go through copy_from_user() and endian data has to go
> through le32_to_cpu() etc.

__bitwise is not only to ensure endian correctness.  It can be used to
define data types which are integer-based, but treated as a distinct
data type by sparse.  A pci_channel_state_t value cannot be assigned
to an integer variable of a different type, for example.

A few arches define arch_xchg() and arch_cmpxchg() as pure macros.
The sparse warning for pci_channel_state_t does not appear on those
arches.  (These are:  arc csky riscv x86)

All other arches use a mix of macros and static inlines to define
arch_xchg() and arch_cmpxchg().  The static inlines use unsigned long
as argument and return types and the macros cast the argument type to
unsigned long.

Why are the casts necessary?  Because there are callers of xchg() and
cmpxchg() which pass pointers instead of integers as arguments.
Examples include llist_del_all(), __wake_q_add(), mark_oom_victim(),
fsnotify_attach_connector_to_object().  (Note that NULL is defined as
"(void *)0".)

When using xchg() or cmpxchg() with __bitwise arguments (as is done
by commit 74ff8864cc84 in pci_dev_set_io_state()), the arches which
define arch_xchg() and arch_cmpxchg() with static inlines see sparse
warnings because the __bitwise arguments are cast to unsigned long.
Those arches are:  alpha arm arm64 hexagon loongarch m68k mips openrisc
parisc powerpc s390 sh sparc xtensa

Indeed adding __force to the cast, as you suggest, should avoid the
issue.  sparse cannot parse the inline assembler, so it does not
understand that arch_xchg() and arch_cmpxchg() internally perform a
comparison and/or assignment.  By adding __force, we therefore do not
lose any validation coverage.

A better approach might be to teach sparse that arch_xchg() and
arch_cmpxchg() internally perform a comparison and/or assignment.
Then sparse could validate the argument and return value types.

builtin.c in the sparse source code already contains functions
to handle __atomic_exchange() and __atomic_compare_exchange(),
so I think xchg() and cmpxchg() should be handled there as well.

Unfortunately the sparse source code does not feel very approachable
to me:  E.g. the builtins_common[] table wants a return type of the
function, but the return type can be either an integer or a pointer
in this case.  How do I encode this?  Some entries in the table use
NULL as return value, is that a way to tell sparse that the return
type is variable?  NULL does not seem to mean void, because there's
a separate void_ctype for that.  Documentation is nearly non-existent.

Another issue is that the last commit to the sparse repository was
made 17 months ago.  Patches submitted to linux-sparse are ignored,
e.g. this one submitted by you half a year ago:

https://lore.kernel.org/linux-sparse/ZIyt1uUYW%2FYXEluw@moroto/

It appears sparse is unmaintained, so it's unclear if it's worth
investing time to add xchg() / cmpxchg() support.  I cannot blame
the maintainer as the source code seems less than simple to understand.

Suddenly the __force solution you've proposed looks very appealing...

Thoughts?

Thanks,

Lukas

> > On Wed, Mar 01, 2023 at 04:39:24AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   e492250d5252635b6c97d52eddf2792ec26f1ec1
> > > commit: 74ff8864cc842be994853095dba6db48e716400a PCI: hotplug: Allow marking devices as disconnected during bind/unbind
> > > date:   13 days ago
> > > config: loongarch-randconfig-s042-20230226 (https://download.01.org/0day-ci/archive/20230301/202303010454.jI5Jg2sT-lkp@intel.com/config)
> > > compiler: loongarch64-linux-gcc (GCC) 12.1.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # apt-get install sparse
> > >         # sparse version: v0.6.4-39-gce1a6720-dirty
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74ff8864cc842be994853095dba6db48e716400a
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 74ff8864cc842be994853095dba6db48e716400a
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Link: https://lore.kernel.org/oe-kbuild-all/202303010454.jI5Jg2sT-lkp@intel.com/
> > > 
> > > sparse warnings: (new ones prefixed by >>)
> > >    drivers/pci/pcie/err.c: note: in included file:
> > > >> drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast from restricted pci_channel_state_t
> > > >> drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast to restricted pci_channel_state_t
> > >    drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast from restricted pci_channel_state_t
> > >    drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast from restricted pci_channel_state_t
> > >    drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast to restricted pci_channel_state_t
> > >    drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast from restricted pci_channel_state_t
> > >    drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast from restricted pci_channel_state_t
> > >    drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast to restricted pci_channel_state_t
> > > >> drivers/pci/pcie/../pci.h:325:17: sparse: sparse: cast to restricted pci_channel_state_t
> > >    drivers/pci/pcie/../pci.h:328:23: sparse: sparse: cast to restricted pci_channel_state_t
> > >    drivers/pci/pcie/../pci.h:332:23: sparse: sparse: cast to restricted pci_channel_state_t
> > > 
> > > vim +325 drivers/pci/pcie/../pci.h
> > > 
> > >    306	
> > >    307	/**
> > >    308	 * pci_dev_set_io_state - Set the new error state if possible.
> > >    309	 *
> > >    310	 * @dev: PCI device to set new error_state
> > >    311	 * @new: the state we want dev to be in
> > >    312	 *
> > >    313	 * If the device is experiencing perm_failure, it has to remain in that state.
> > >    314	 * Any other transition is allowed.
> > >    315	 *
> > >    316	 * Returns true if state has been changed to the requested state.
> > >    317	 */
> > >    318	static inline bool pci_dev_set_io_state(struct pci_dev *dev,
> > >    319						pci_channel_state_t new)
> > >    320	{
> > >    321		pci_channel_state_t old;
> > >    322	
> > >    323		switch (new) {
> > >    324		case pci_channel_io_perm_failure:
> > >  > 325			xchg(&dev->error_state, pci_channel_io_perm_failure);
> > >    326			return true;
> > >    327		case pci_channel_io_frozen:
> > >    328			old = cmpxchg(&dev->error_state, pci_channel_io_normal,
> > >    329				      pci_channel_io_frozen);
> > >    330			return old != pci_channel_io_perm_failure;
> > >    331		case pci_channel_io_normal:
> > >    332			old = cmpxchg(&dev->error_state, pci_channel_io_frozen,
> > >    333				      pci_channel_io_normal);
> > >    334			return old != pci_channel_io_perm_failure;
> > >    335		default:
> > >    336			return false;
> > >    337		}
> > >    338	}
> > >    339	
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests
