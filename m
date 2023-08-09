Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD36C775213
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 06:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjHIExq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 00:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIExo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:53:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33884172A;
        Tue,  8 Aug 2023 21:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691556816;
        bh=aLsuRyNueNps0bFQ4pQb+x6W7rQ/5KpaQNJlP45Vnz8=;
        h=Date:From:To:Cc:Subject:From;
        b=LGr9OY/jEncvFqrh4bN3YngPbbY6UMSB/5i7iiUYiPbvG6+WiNFx+K7CwBw2NE7lp
         u9TTY+nix45g9gOnaE6aSEnboMZCbwtxjhKYARtIhHeGmeLHtnbhmOdad8TflI0iWP
         elMG5jF+slADeve+tHaiLRvgCfwVG9SSeumz9sOaMpxLVKCbrzNvbzeoj7HGzGuzLW
         diWUSHj+rMUGK2/F+rLLDW17hxVoLkEA6DRP1Xp3SVImNVeyjLgq03j3UJwEeCIud4
         LE3WQRqX/uAHh5XTYH+j7HJ50ysbubFCoCFUmJFTlyhRDCdKfgDNgvKR4J61NBjK1w
         kqyr/aJTQKc/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLHkl1q0Mz4wy0;
        Wed,  9 Aug 2023 14:53:35 +1000 (AEST)
Date:   Wed, 9 Aug 2023 14:53:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Maher Sanalla <msanalla@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: linux-next: manual merge of the bitmap tree with the net-next tree
Message-ID: <20230809145333.03f31309@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IJJROMl7gUlfPHMeKnbCfDf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IJJROMl7gUlfPHMeKnbCfDf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/eq.c

between commits:

  54b2cf41b853 ("net/mlx5: Refactor completion IRQ request/release handlers=
 in EQ layer")
  ddd2c79da020 ("net/mlx5: Introduce mlx5_cpumask_default_spread")

from the net-next tree and commit:

  a4be5fa84bb2 ("net: mlx5: switch comp_irqs_request() to using for_each_nu=
ma_cpu")

from the bitmap tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/mellanox/mlx5/core/eq.c
index ea0405e0a43f,7c8dc0443d6a..000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@@ -815,112 -803,82 +815,105 @@@ void mlx5_eq_update_ci(struct mlx5_eq *
  }
  EXPORT_SYMBOL(mlx5_eq_update_ci);
 =20
 -static void comp_irqs_release_pci(struct mlx5_core_dev *dev)
 +static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
  {
  	struct mlx5_eq_table *table =3D dev->priv.eq_table;
 +	struct mlx5_irq *irq;
 =20
 -	mlx5_irqs_release_vectors(table->comp_irqs, table->num_comp_eqs);
 +	irq =3D xa_load(&table->comp_irqs, vecidx);
 +	if (!irq)
 +		return;
 +
 +	xa_erase(&table->comp_irqs, vecidx);
 +	mlx5_irq_release_vector(irq);
  }
 =20
 -static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
 +static int mlx5_cpumask_default_spread(int numa_node, int index)
  {
- 	const struct cpumask *prev =3D cpu_none_mask;
- 	const struct cpumask *mask;
 -	struct mlx5_eq_table *table =3D dev->priv.eq_table;
 -	int ncomp_eqs;
 -	u16 *cpus;
 -	int ret;
 +	int found_cpu =3D 0;
 +	int i =3D 0;
- 	int cpu;
+ 	int cpu, hop;
 -	int i;
 =20
 -	ncomp_eqs =3D table->num_comp_eqs;
 -	cpus =3D kcalloc(ncomp_eqs, sizeof(*cpus), GFP_KERNEL);
 -	if (!cpus)
 -		return -ENOMEM;
 -
 -	i =3D 0;
  	rcu_read_lock();
- 	for_each_numa_hop_mask(mask, numa_node) {
- 		for_each_cpu_andnot(cpu, mask, prev) {
- 			if (i++ =3D=3D index) {
- 				found_cpu =3D cpu;
- 				goto spread_done;
- 			}
 -	for_each_numa_online_cpu(cpu, hop, dev->priv.numa_node) {
 -		cpus[i] =3D cpu;
 -		if (++i =3D=3D ncomp_eqs)
++	for_each_numa_online_cpu(cpu, hop, numa_node) {
++		if (i++ =3D=3D index) {
++			found_cpu =3D cpu;
+ 			break;
 +		}
- 		prev =3D mask;
  	}
-=20
- spread_done:
  	rcu_read_unlock();
 -	ret =3D mlx5_irqs_request_vectors(dev, cpus, ncomp_eqs, table->comp_irqs=
, &table->rmap);
 -	kfree(cpus);
 -	return ret;
 +	return found_cpu;
  }
 =20
 -static void comp_irqs_release_sf(struct mlx5_core_dev *dev)
 +static struct cpu_rmap *mlx5_eq_table_get_pci_rmap(struct mlx5_core_dev *=
dev)
  {
 -	struct mlx5_eq_table *table =3D dev->priv.eq_table;
 -
 -	mlx5_irq_affinity_irqs_release(dev, table->comp_irqs, table->num_comp_eq=
s);
 +#ifdef CONFIG_RFS_ACCEL
 +#ifdef CONFIG_MLX5_SF
 +	if (mlx5_core_is_sf(dev))
 +		return dev->priv.parent_mdev->priv.eq_table->rmap;
 +#endif
 +	return dev->priv.eq_table->rmap;
 +#else
 +	return NULL;
 +#endif
  }
 =20
 -static int comp_irqs_request_sf(struct mlx5_core_dev *dev)
 +static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
  {
  	struct mlx5_eq_table *table =3D dev->priv.eq_table;
 -	int ncomp_eqs =3D table->num_comp_eqs;
 +	struct cpu_rmap *rmap;
 +	struct mlx5_irq *irq;
 +	int cpu;
 =20
 -	return mlx5_irq_affinity_irqs_request_auto(dev, ncomp_eqs, table->comp_i=
rqs);
 +	rmap =3D mlx5_eq_table_get_pci_rmap(dev);
 +	cpu =3D mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
 +	irq =3D mlx5_irq_request_vector(dev, cpu, vecidx, &rmap);
 +	if (IS_ERR(irq))
 +		return PTR_ERR(irq);
 +
 +	return xa_err(xa_store(&table->comp_irqs, vecidx, irq, GFP_KERNEL));
  }
 =20
 -static void comp_irqs_release(struct mlx5_core_dev *dev)
 +static void comp_irq_release_sf(struct mlx5_core_dev *dev, u16 vecidx)
  {
  	struct mlx5_eq_table *table =3D dev->priv.eq_table;
 +	struct mlx5_irq *irq;
 =20
 -	mlx5_core_is_sf(dev) ? comp_irqs_release_sf(dev) :
 -			       comp_irqs_release_pci(dev);
 +	irq =3D xa_load(&table->comp_irqs, vecidx);
 +	if (!irq)
 +		return;
 =20
 -	kfree(table->comp_irqs);
 +	xa_erase(&table->comp_irqs, vecidx);
 +	mlx5_irq_affinity_irq_release(dev, irq);
  }
 =20
 -static int comp_irqs_request(struct mlx5_core_dev *dev)
 +static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
  {
  	struct mlx5_eq_table *table =3D dev->priv.eq_table;
 -	int ncomp_eqs;
 -	int ret;
 +	struct mlx5_irq *irq;
 =20
 -	ncomp_eqs =3D table->num_comp_eqs;
 -	table->comp_irqs =3D kcalloc(ncomp_eqs, sizeof(*table->comp_irqs), GFP_K=
ERNEL);
 -	if (!table->comp_irqs)
 -		return -ENOMEM;
 +	irq =3D mlx5_irq_affinity_irq_request_auto(dev, &table->used_cpus, vecid=
x);
 +	if (IS_ERR(irq)) {
 +		/* In case SF irq pool does not exist, fallback to the PF irqs*/
 +		if (PTR_ERR(irq) =3D=3D -ENOENT)
 +			return comp_irq_request_pci(dev, vecidx);
 =20
 -	ret =3D mlx5_core_is_sf(dev) ? comp_irqs_request_sf(dev) :
 -				     comp_irqs_request_pci(dev);
 -	if (ret < 0)
 -		kfree(table->comp_irqs);
 +		return PTR_ERR(irq);
 +	}
 =20
 -	return ret;
 +	return xa_err(xa_store(&table->comp_irqs, vecidx, irq, GFP_KERNEL));
 +}
 +
 +static void comp_irq_release(struct mlx5_core_dev *dev, u16 vecidx)
 +{
 +	mlx5_core_is_sf(dev) ? comp_irq_release_sf(dev, vecidx) :
 +			       comp_irq_release_pci(dev, vecidx);
 +}
 +
 +static int comp_irq_request(struct mlx5_core_dev *dev, u16 vecidx)
 +{
 +	return mlx5_core_is_sf(dev) ? comp_irq_request_sf(dev, vecidx) :
 +				      comp_irq_request_pci(dev, vecidx);
  }
 =20
  #ifdef CONFIG_RFS_ACCEL

--Sig_/IJJROMl7gUlfPHMeKnbCfDf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTTG80ACgkQAVBC80lX
0Gw9Lgf9FHT6ewnyAYc/pVrsLcMfSpVkP3c53BUUIh6pYfrTP52zhIjSvYKMe5fI
KO00kqFC096QqNqLJWZVK6GgJMC7O3SlGpNokEd5MNbfEOsGWFvpWChjX7D9aWd9
gu8iemW3FTiwUI9K65/BjZYy4tH2vigoLyvWyWtbroISYlHvC5NnYEd5rsn9WUud
9BeErfdHjdp+WvO5AUouix/5OaFvFJCDhYojqBzW0/0t6lZqOyuUdP6Gm/QelI60
0cCMHURdjqQNWSIBZGf3z6/bsfxdfmvTNOk0ieqE3r0ZMa7ua6SZb8HyoEOpNWcn
BfRTZtOGcKkWLjIwrJ7WTKhqzNkneQ==
=vqHv
-----END PGP SIGNATURE-----

--Sig_/IJJROMl7gUlfPHMeKnbCfDf--
